module TestHelpers

  def sign_in_as(user)
    visit '/'
    click_link 'Sign In'
    fill_in "Login", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
  end


end
