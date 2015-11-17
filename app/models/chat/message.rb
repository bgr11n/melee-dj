module Chat
  class Message
    include Mongoid::Document
    include Mongoid::Timestamps

    field :text, type: String

    belongs_to :chat, class_name: 'Party::Chat'
    belongs_to :user

    def as_json options={}
      {
        id: id.to_s,
        text: text,
        created_at: created_at,
        updated_at: updated_at,
        user: user
      }
    end
  end
end
