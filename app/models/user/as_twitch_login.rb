class User::AsTwitchLogin < ActiveType::Record[User]

  attr_accessor :display_name, :_id, :name, :type, :bio, :logo, :_links, :partnered, :notifications

  before_save :set_source


  private

  def set_source
    self.source = 'twitch'
  end

end
