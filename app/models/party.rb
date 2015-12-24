class Party
  include Mongoid::Document
  include Mongoid::Timestamps

  field :active, type: Boolean, default: true
  field :title, type: String

  belongs_to :user
  has_one :chat, class_name: 'Party::Chat'
  has_one :playlist, class_name: 'Party::Playlist'
end
