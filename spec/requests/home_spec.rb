require 'rails_helper'

RSpec.describe 'Staticpages/home', type: :request do
  describe 'home template' do
    before do
      get root_path
    end

    it 'response successfully' do
      expect(response).to be_successful
      expect(response).to have_http_status 200
    end

    it 'correct title' do
      expect(response.body).to include "#{BASE_TITLE}"
    end

    it 'correct header' do
      expect(response.body).to include 'Home'
      expect(response.body).to include 'Sign Up'
      expect(response.body).to include 'login'
    end
  end
end
