require 'rails_helper'

RSpec.feature 'post/edit', type: :system do
  let(:user) { create(:user) }
  let(:post) { create(:post, id: 1, user_id: user.id) }
  let!(:category) { create(:category) }

  scenario '投稿詳細ページから投稿を編集できる' do
    login(user)
    new_post
    expect(page).to have_link '投稿を編集'
    click_on '投稿を編集'
    fill_in 'Content', with: 'test edit post'
    attach_file 'Image', "app/assets/images/course-1.png"
    select 'レジャー', from: "post[category_id]"
    click_on 'Update'
    expect(page).to have_content '編集しました'
  end
end
