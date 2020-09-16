module LoginMacros
  def login(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    expect(page).to have_content 'Signed in successfully'
  end

  def logout
    click_on 'account'
    click_on 'Log out'
    expect(page).to have_content 'Signed out successfully'
  end

  def new_post
    visit new_post_path
    fill_in 'Content', with: 'test'
    attach_file 'Image', "app/assets/images/course-1.png"
    click_on 'Post'
  end
end
