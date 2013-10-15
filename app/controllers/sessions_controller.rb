class SessionsController < ApplicationController

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    if user.present?
      redirect_to users_path, notice: "Signed in!"
    else
      redirect_to root_path, notice: "Sign in was not successful"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to users_path, notice: "Signed out"
  end
end
