module ApplicationHelper
  def full_title(page_title ='')
    base_title = "WAKER"
    if page_title.blank?
      base_title
    else
      "#{page_title} - #{base_title}"
    end
  end

  # 引数で与えられたユーザーのGravatar画像を返す
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.username, class: "gravatar")
  end
end
