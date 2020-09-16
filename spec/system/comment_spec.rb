require 'rails_helper'

RSpec.feature 'comment for post', type: :system do
  let(:user) { create(:user) }

  scenario 'コメントを入力し送信するとコメントできる' do
    login(user)
    new_post
    fill_in 'comment', with: 'hey!'
    click_on 'コメントする'
    expect(page).to have_content 'hey!'
  end
end
