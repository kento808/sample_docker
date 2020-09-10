require 'rails_helper'

RSpec.feature 'profile_edit', type: :system do
  let(:user) { create(:user) }

  background do
    login(user)
    visit root_path
  end

  scenario '項目を入力しupdateをクリックすると更新できる' do
    click_on 'Account'
    expect(page).to have_link 'Setting'
    click_on 'Setting'
    expect(page).to have_content 'profile edit'
    fill_in '自己紹介', with: 'hello'
    click_on 'Update'
    expect(current_path).to eq user_path(user)
    expect(page).to have_content '編集しました！'
  end

  scenario 'username emailが入力されていない場合更新できない' do
    click_on 'Account'
    expect(page).to have_link 'Setting'
    click_on 'Setting'
    expect(page).to have_content 'profile edit'
    fill_in 'Username',    with: nil
    fill_in 'メールアドレス', with: nil
    click_on 'Update'
    expect(page).to have_content "Username can't be blank"
    expect(page).to have_content "Email can't be blank"
  end
end
