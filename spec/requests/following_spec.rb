require 'rails_helper'

RSpec.describe 'following', type: :request do
  let(:jone)   { create(:user) }
  let(:michel) { create(:user) }

  describe 'following page' do
    before do
      sign_in(jone)
      jone.follow(michel)
      michel.follow(jone)
    end

    it 'following' do
      get following_user_path(jone)
      expect(jone.following.empty?).to be_falsey
      expect(response.body).to match jone.following.count.to_s
    end

    it 'follower' do
      get followers_user_path(jone)
      expect(jone.followers.empty?).to be_falsey
      expect(response.body).to match jone.followers.count.to_s
    end
  end
end
