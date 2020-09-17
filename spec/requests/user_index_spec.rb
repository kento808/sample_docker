require 'rails_helper'

RSpec.describe 'user/index', type: :request do

  let(:user)  { create(:user) }
  let!(:users) { create_list(:user, 21) }

  describe 'index page' do
    before do
      sign_in(user)
      get users_path
    end

    it 'respone success' do
      expect(response).to be_successful
    end

    it 'correct title' do
      expect(response.body).to include "ユーザー一覧 - #{BASE_TITLE}"
    end

    it 'users size correct' do
      expect(assigns(:users).size).to eq 20
    end
  end
end
