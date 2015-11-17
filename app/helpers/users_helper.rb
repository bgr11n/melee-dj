require "net/http"

module UsersHelper
  def party_owner_or_admin
    user_signed_in? && (current_user.id == @party.user_id || current_user.grand?)
  end

  def current_user
    @current_user ||= User.find session[:user_id] if session[:user_id].present?
  end

  def user_signed_in?
    current_user.present?
  end
end
