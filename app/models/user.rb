class User
  # Make users like moderator for specific party
  SOURCES = [:auth, :twitch]

  include Mongoid::Document
  include Mongoid::Timestamps

  field :nickname,              type: String
  field :email,                 type: String
  field :source,                type: String
  field :grand,                 type: Boolean,      default: false
  field :password_hash,         type: String
  field :password_salt,         type: String

  has_one :party

  alias_method :grand?, :grand

  validates :email, uniqueness: true, presence: true, format: { with: /[a-zA-Z0-9_.+-]+@[\.a-zA-Z0-9-]+/ }
  validates :nickname, uniqueness: true

  def has_password? password
    self.password_hash == BCrypt::Engine.hash_secret(password, self.password_salt)
  end

  def have_party?
    self.party.present?
  end

  SOURCES.each do |_source|
    define_method "from_#{_source}?" do
      _source.to_s == source.to_s
    end
  end
end
