class Party
  class Chat
    include Mongoid::Document
    include Mongoid::Timestamps

    belongs_to :party
  end
end
