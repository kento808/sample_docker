require 'rails_helper'

RSpec.describe 'like_index', type: :request do
  let(:jone)  { create(:user) }
  let(:user)  { create(:user) }
  let(:post)  { create(:post) }

  before do
    sign_in(jone)
    get root_path
  end

  it 'not liked_posts' do
    get likes_path
    expect(response.body).to include 'お気に入りはまだありません'
  end

  it 'have liked_posts' do
    post.favorlit(jone)
    get likes_path
    expect(response.body).to include 'お気に入りの投稿 ( 1 )'
  end
end
