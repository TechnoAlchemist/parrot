require 'spec_helper'

feature 'admin signs up', %Q{
  As an unregistered admin
  I want to sign up for Parrot
  So that I can create and manage pairing assignments
} do

  # Acceptance Criteria:
  #
  # * Admin must sign up through GitHub
  # * Admin will be redirected to the home page
  # * If GitHub account does not include all of the
  #   required sign up criteria (name, email), admin
  #   must complete all sign up criteria

  scenario 'admin signs up with valid login credentials' do
    set_omniauth
    visit users_path
    click_link 'Sign in with GitHub'

    expect(current_path).to eql(users_path)
    expect(page).to have_content('Signed in as')
  end

  scenario 'admin signs up with invalid login credentials' do
    set_invalid_omniauth

    visit users_path
    click_link 'Sign in with GitHub'

    expect(current_path).to eql(new_user_path)
    expect(page).to have_content('')
  end
end
