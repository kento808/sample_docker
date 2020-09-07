class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, length: { maximum: 50 }
  validates :email,    presence: true, length: { maximum: 255 }
  validates :profile,                  length: { maximum: 500 }

  has_many :posts, dependent: :destroy

  def feed
    Post.where("user_id = ?", id)
  end

end
