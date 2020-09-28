require 'rails_helper'

RSpec.feature 'user_post', type: :system do
  given(:jone)   { create(:user) }
  given(:michel) { create(:user) }
  given!(:category) { create(:category) }

  scenario '正しいユーザーの場合投稿できる' do
    login(jone)
    expect(page).to have_link '投稿する'
    click_on '投稿する'
    expect(current_path).to eq new_post_path
    fill_in 'Content', with: 'test'
    attach_file 'Image', "app/assets/images/course-1.png"
    select 'レジャー', from: "post[category_id]"
    click_on 'Post'
    expect(page).to have_content "投稿しました！"
  end

  scenario '本人ではないユーザーの場合投稿できない' do
    login(jone)
    visit user_path(michel)
    expect(page).not_to have_content '投稿する'
  end
end
