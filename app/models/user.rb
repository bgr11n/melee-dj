class User

  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String
  field :password_hash, type: String
  field :password_salt, type: String

  def has_password? password
    self.password_hash == BCrypt::Engine.hash_secret(password, self.password_salt)
  end

end
