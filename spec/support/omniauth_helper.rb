module OmniAuthHelpers

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
        },
      "role" => credentials[:role]
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
