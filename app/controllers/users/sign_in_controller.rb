class Users::SignInController < ApplicationController

  def new
    build_sign_in
  end

  def create
    build_sign_in
    save_sign_in or render 'new'
  end

  def destroy
    reset_session
    redirect_to root_url, notice: 'Signed Out!'
  end

  private

  def build_sign_in
    @sign_in ||= User::AsSignIn.new(sign_in_params)
  end

  def save_sign_in
    if @sign_in.save
      session[:user_id] = @sign_in.user.id
      redirect_to root_url, notice: 'Signed In!'
    end
  end

  def sign_in_params
    sign_in_params = params[:user_as_sign_in]
    sign_in_params = sign_in_params.permit(:email, :password) if sign_in_params
  end

end
