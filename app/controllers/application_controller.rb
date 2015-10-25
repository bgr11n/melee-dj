class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def authenticate!
    redirect_to sign_in_path unless user_signed_in?
  end

  def log_in_user
    session[:user_id] = @user.id
    redirect_to root_url, flash: { success: 'Signed In!' }
  end

end
