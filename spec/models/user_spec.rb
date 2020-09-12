require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { create(:user) }
  let(:invalid_user) { build(:user, username: 'ruby', email: '', password: 'password')}
  let(:invalid_user2) { build(:user, username: "a" * 51, email: 'email', password: 'password')}
  let(:invalid_user3) { build(:user, profile: "a" * 501) }
  let(:jone)   { create(:user) }
  let(:michel) { create(:user) }
  let(:post)   { create(:post) }

  it 'valid user' do
    user.valid?
    expect(user).to be_valid
  end

  it 'validates presence' do
    invalid_user.valid?
    expect(invalid_user.errors[:email]).to include("can't be blank")
  end

  it 'validates user maximum' do
    invalid_user2.valid?
    expect(invalid_user2.errors[:username]).to include("is too long (maximum is 50 characters)")
  end

  it 'validates user profile maximum' do
    invalid_user3.valid?
    expect(invalid_user3.errors[:profile]).to include("is too long (maximum is 500 characters)")
  end

  it 'dependent destroy for post' do
    user.posts.create(content: 'content')
    expect{ user.destroy }.to change{ Post.count }.by(-1)
  end

  it 'follow method' do
    expect(jone.following?(michel)).to be_falsey
    jone.follow(michel)
    expect(jone.following?(michel)).to be_truthy
  end

  it 'passive relation followers' do
    jone.follow(michel)
    expect(michel.followers.include?(jone)).to be_truthy
  end

  it 'unfollow method' do
    jone.follow(michel)
    jone.unfollow(michel)
    expect(jone.following?(michel)).to be_falsey
  end

  it 'dependent destroy comment' do
    @comment = Comment.create(user_id: user.id, post_id: post.id, comment: 'comment')
    expect{ user.destroy }.to change{ Comment.count }.by(-1)
  end
end
