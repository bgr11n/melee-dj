class User::AsTwitchLogin < ActiveType::Record[User]
  attr_accessor :display_name, :_id, :name, :type, :bio, :logo, :_links, :partnered, :notifications

  before_save :set_source
  before_save :set_nickname

  def self.fetch_or_create user_data
    user = where(email: user_data['email']).first
    user.blank? ? new(user_data) : user
  end

  private

  def set_nickname
    self.nickname = display_name
  end

  def set_source
    self.source = 'twitch'
  end
end
