class User
  class AsSignUp < ActiveType::Record[User]
    attr_accessor :password

    validates :password, presence: true, confirmation: true

    before_save :set_source
    before_save :set_nickname
    before_save :encrypt_password

    private

    def set_source
      self.source = 'auth'
    end

    def set_nickname
      self.nickname = email.match(/^[^\@]*/)[0] unless nickname.blank?
    end

    def encrypt_password
      if password.present?
        self.password_salt = BCrypt::Engine.generate_salt
        self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
      end
    end
  end
end
