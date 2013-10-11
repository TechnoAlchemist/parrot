class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index

  end

  def show
  end

  def new
    @user = User.from_omniauth(env["omniauth.auth"])
  end

  def create
    binding.pry
    @user = User.new(user_params)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name)
  end

end
