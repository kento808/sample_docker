require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:invalid_post) { build(:post, content: "") }
  let(:invalid_post2) { build(:post, content: "a" * 1001) }

  it 'valid post' do
    post.valid?
    expect(post).to be_valid
  end

  it 'validates presence' do
    invalid_post.valid?
    expect(invalid_post.errors[:content]).to include("can't be blank")
  end

  it 'validates maximum' do
    invalid_post2.valid?
    expect(invalid_post2.errors[:content]).to include "is too long (maximum is 1000 characters)"
  end

  it 'dependent comment' do
    user.comments.create(comment: 'comment', user_id: user.id, post_id: post.id)
    expect { post.destroy }.to change(Comment, :count).by(-1)
  end

  it 'dependent like' do
    user.likes.create(user_id: user.id, post_id: post.id)
    expect { post.destroy }.to change(Like, :count).by(-1)
  end
end
