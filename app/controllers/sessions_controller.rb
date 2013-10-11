class SessionsController < ApplicationController
  before do
    request.env["devise.mapping"] = Devise.mappings[:user]
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
  end


  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to users_path, notice: "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to users_path, notice: "Signed out"
  end
end
