class User::AsSignIn < PlainModel

  attr_accessor :email
  attr_accessor :password

  validate :validate_user_exists
  validate :validate_user_from_auth
  validate :validate_password_correct

  def user
    User.where(email: email).first if email.present?
  end


  private

  def validate_user_exists
    errors.add(:email, 'User not found') if user.blank?
  end

  def validate_user_from_auth
    errors.add(:email, "Please, log in through #{user.source.capitalize}") unless user.from_auth?
  end

  def validate_password_correct
    errors.add(:password, 'Incorrect password') if user && !user.has_password?(password)
  end

end
