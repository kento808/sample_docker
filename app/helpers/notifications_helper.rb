module NotificationsHelper
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end

  def notification_form(notification)
    @comment = nil
    visitor = link_to notification.visitor.username, notification.visitor, style: "font-weight: bold;"
    your_post = link_to 'あなたの投稿', notification.post, style: "font-weight: bold;", local: true
    case notification.action
    when "follow"
      "#{visitor}があなたをフォローしました"
    when "like"
      "#{visitor}が#{your_post}にいいね！しました"
    when "comment" then
      @comment = Comment.find_by(id: notification.comment_id)&.comment
      "#{visitor}が#{your_post}にコメントしました"
    end
  end
end
