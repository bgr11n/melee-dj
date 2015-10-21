class Users::SignUpController < ApplicationController

  def new
    build_user
  end

  def create
    build_user
    user_save or render 'new'
  end

  private

  def build_user
    @user ||= User::AsSignUp.new(user_params)
  end

  def user_save
    redirect_to sign_in_path, notice: 'Signed Up! You can now Log In.' if @user.save
  end

  def user_params
    user_params = params[:user]
    user_params.permit(:email, :password, :password_confirmation) if user_params
  end

end
