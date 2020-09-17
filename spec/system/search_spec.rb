require 'rails_helper'

RSpec.feature 'search', type: :system do
  let(:user) { create(:user) }

  scenario '検索ワードを入力しボタンを押すと検索結果ページが表示される' do
    login(user)
    visit users_path
    select 'user', from: 'select'
    fill_in 'search', with: 'Example'
    click_on 'Search'
    expect(page).to have_content 'User'
    expect(current_path).to eq '/search'
  end
end
