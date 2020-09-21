require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:post) { create(:post) }

  before do
    @comment = Comment.create(user_id: user.id, post_id: post.id, comment: 'comment')
  end

  it 'valid comment' do
    @comment.valid?
    expect(@comment).to be_valid
  end

  it 'validates presence' do
    @comment.comment = nil
    @comment.valid?
    expect(@comment).to be_invalid
  end

  it 'validate maximum' do
    @comment.comment = "a" * 301
    @comment.valid?
    expect(@comment.errors[:comment]).to include "is too long (maximum is 300 characters)"
  end

  it 'dependent notification' do
    @comment.notifications.create(visitor_id: user.id, visited_id: user2.id, comment_id: @comment.id, action: 'comment')
    expect{ @comment.destroy }.to change{ Notification.count }.by(-1)
  end
end
