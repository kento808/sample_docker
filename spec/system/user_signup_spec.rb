require 'rails_helper'

RSpec.feature 'user_signup', type: :system do
  background do
    visit root_path
  end

  scenario '必要事項を入力しsign upすると成功する' do
    expect(page).to have_link 'Sign Up'
    click_on 'Sign Up'
    expect(current_path).to eq new_user_registration_path
    fill_in 'Username', with: 'example'
    fill_in 'Email', with: 'foo@co.jp'
    fill_in 'Password', with: '123456'
    fill_in 'Confirmation', with: '123456'
    click_on 'Create my account'
    expect(page).to have_content 'signed up successfully'
  end

  scenario '入力ミスがあるとsign up が成功しない' do
    expect(page).to have_link 'Sign Up'
    click_on 'Sign Up'
    expect(current_path).to eq new_user_registration_path
    fill_in 'Username', with: 'example'
    fill_in 'Email', with: ''
    fill_in 'Password', with: '123456'
    fill_in 'Confirmation', with: '123456'
    click_on 'Create my account'
    expect(page).to have_content "can't be blank"
  end
end
