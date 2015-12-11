module UsersHelper
  def party_owner_or_admin
    user_signed_in? && (party_owner || current_user.grand?)
  end

  def party_owner
    current_user.id == @party.user_id
  end

  def current_user
    @current_user ||= User.find session[:user_id] if session[:user_id].present?
  end

  def user_signed_in?
    current_user.present?
  end
end
