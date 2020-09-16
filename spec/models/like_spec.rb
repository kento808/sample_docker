require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  before do
    @like = Like.new(user_id: user.id, post_id: post.id)
  end

  it 'valid like' do
    @like.valid?
    expect(@like).to be_valid
  end

  it 'validates presence' do
    @like.user_id = nil
    @like.valid?
    expect(@like).to be_invalid
  end

  it 'validate error' do
    @like.post_id = nil
    @like.valid?
    expect(@like.errors[:post_id]).to include "can't be blank"
  end
end
