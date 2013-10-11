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

def set_omniauth(opts = {})
  default = {:provider => :github,
             :uuid     => '123545',
             :github => {
                :nickname => 'annek',
                :email => "foobar@example.com",
                :name => 'johhny parrot'
              }
            }

  credentials = default.merge(opts)
  provider = credentials[:provider]
  user_hash = credentials[provider]

  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[provider] = {
    'provider' => 'github',
    'uid' => credentials[:uuid],
    "info" => {
      "email" => user_hash[:email],
      "nickname" => user_hash[:nickname],
      "name" => user_hash[:name]
      }
    }
end

def set_invalid_omniauth(opts = {})
  credentials = { :provider => :github,
                  :invalid  => :invalid_crendentials
                 }.merge(opts)

  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[credentials[:provider]] = credentials[:invalid]

end

end
