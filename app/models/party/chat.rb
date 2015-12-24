class Party
  class Party::Chat
    include Mongoid::Document
    include Mongoid::Timestamps

    belongs_to :party
    has_many :messages, class_name: 'Chat::Message'
  end
end
