class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @feed_items = current_user.feed.limit(7).order(created_at: 'DESC')
    end
  end
end
