require 'rails_helper'

RSpec.feature 'user_login', type: :system do

  let(:user) { create(:user, email: 'test@co.jp', password: 'testuser') }

  background do
    visit root_path
  end

  scenario '必要事項を入力しloginをクリックすると成功する' do
    expect(page).to have_link 'login'
    click_on 'login'
    expect(current_path).to eq new_user_session_path
    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    expect(page).to have_content 'Signed in successfully'
  end

  scenario '入力ミスがあるとloginが成功しない' do
    expect(page).to have_link 'login'
    click_on 'login'
    expect(current_path).to eq new_user_session_path
    fill_in 'Email',    with: user.email
    fill_in 'Password', with: ''
    click_on 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end
end
