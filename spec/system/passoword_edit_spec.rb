require 'rails_helper'

RSpec.feature 'password_edit', type: :system do
  let(:user) { create(:user) }

  background do
    login(user)
    visit profile_edit_path
  end

  scenario '新しいパスワードと現在のパスワードを入力すると変更できる' do
    click_on 'password edit?'
    expect(page).to have_content 'パスワード編集'
    fill_in '新しいパスワード', with: '12345678'
    fill_in '新しいパスワード(確認用)', with: '12345678'
    fill_in '現在のパスワード',   with: user.password
    click_on 'Update'
    expect(page).to have_content 'updated successfully.'
  end

  scenario '新しいパスワードが空白の場合更新できない' do
    click_on 'password edit?'
    expect(page).to have_content 'パスワード編集'
    fill_in '新しいパスワード', with: nil
    fill_in '新しいパスワード(確認用)', with: '12345678'
    fill_in '現在のパスワード',   with: user.password
    click_on 'Update'
    expect(page).to have_content "Password can't be blank"
  end
end
