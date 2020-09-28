require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:jone)   { create(:user) }
  let(:michel) { create(:user) }

  before do
    @relation = Relationship.new(follower_id: jone.id,
                                 followed_id: michel.id)
  end

  it 'vilid relation' do
    @relation.valid?
    expect(@relation).to be_valid
  end

  it 'validate  presence follower_id' do
    @relation.follower_id = nil
    @relation.valid?
    expect(@relation.errors[:follower_id]).to include "can't be blank"
  end

  it 'validate presence followed_id' do
    @relation.followed_id = nil
    @relation.valid?
    expect(@relation.errors[:followed_id]).to include "can't be blank"
  end

  it 'follow change count' do
    expect { jone.follow(michel) }.to change { michel.followers.count }.by(1)
  end

  it 'following change count' do
    expect { jone.follow(michel) }.to change { jone.following.count }.by(1)
  end

  it 'unfollow change count' do
    jone.follow(michel)
    expect { jone.unfollow(michel) }.to change { michel.followers.count }.by(-1)
  end

  it 'following change count to unfollow' do
    jone.follow(michel)
    expect { jone.unfollow(michel) }.to change { jone.following.count }.by(-1)
  end
end
