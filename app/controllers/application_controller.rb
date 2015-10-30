class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include UsersHelper
  protect_from_forgery with: :exception

  def asd
    render text: user_signed_in? ? "authenicated" : "not authenicated", layout: 'application'
  end

  private

  def authenticate!
    redirect_to sign_in_path unless user_signed_in?
  end

  def log_in_user
    session[:user_id] = @user.id
    redirect_to root_url, flash: { success: 'Signed In!' }
  end

  def redirect_if_signed_in
    redirect_to root_url if user_signed_in?
  end

end
