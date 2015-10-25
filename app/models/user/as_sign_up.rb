class User::AsSignUp < ActiveType::Record[User]

  attr_accessor :password

  validates :password, presence: true, confirmation: true
  validates :email, format: { with: /[a-zA-Z0-9_.+-]+@[\.a-zA-Z0-9-]+/ }, presence: true, uniqueness: true

  before_save :set_source
  before_save :encrypt_password


  private

  def set_source
    self.source = 'auth'
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end
