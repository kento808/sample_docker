require 'rails_helper'

RSpec.feature 'follow_relation', type: :system do
  let(:jone)   { create(:user) }
  let(:michel) { create(:user) }

  background do
    login(jone)
    visit user_path(michel)
  end

  scenario 'フォローボタンをクリックすると正しく作動している' do
    expect(page).to have_button 'Follow'
    expect(page).to have_content '0 followers'
    click_on 'Follow'
    expect(page).to have_button 'Unfollow'
    expect(page).to have_content '1 followers'
  end

  scenario 'アンフォローボタンをクリックすると正しく動作している' do
    click_on 'Follow'
    expect(page).to have_button 'Unfollow'
    expect(page).to have_content '1 followers'
    click_on 'Unfollow'
    expect(page).to have_content '0 followers'
  end
end
