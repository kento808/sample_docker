class Post < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  belongs_to :user
  belongs_to :category
  has_one_attached :image
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 1000 }
  validates :image,   content_type: {
    in: %w(image/jpeg image/gif image/png),
    message: "must be a valid image format",
  },
                      size: {
                        less_than: 5.megabytes,
                        message: "should be less than 5MB",
                      }

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :favorlit_users, through: :likes, source: :user
  has_many :notifications, dependent: :destroy

  def display_image
    image.variant(resize_to_limit: [500, 500])
  end

  def favorlit(user)
    likes.create(user_id: user.id)
  end

  def unfavorlit(user)
    likes.find_by(user_id: user.id).destroy
  end

  def favorlit?(user)
    favorlit_users.include?(user)
  end

  def Post.search(search, user_or_post)
    if user_or_post == "2"
      Post.where(['content LIKE ?', "%#{search}%"])
    else
      Post.all
    end
  end

  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where([
      "visitor_id = ? and visited_id = ? and post_id = ? and action = ? ",
      current_user.id, user_id, id, 'like',
    ])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).
      distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    # save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
