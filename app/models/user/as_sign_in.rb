
class User::AsSignIn < PlainModel
  attr_accessor :email, :password

  validate :validate_user_exists
  validate :validate_password_correct

  def user
    User.where(email: email).first if email.present?
  end

  private

  def validate_user_exists
    errors.add(:email, 'User not found') if user.blank?
  end

  def validate_password_correct
    # TODO: Error when user try to sign in (form) if he registered form Twitch
    errors.add(:password, 'Incorrect password') if user && !user.has_password?(password)
  end
end
