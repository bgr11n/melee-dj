module Playlist
  class Song
    include Mongoid::Document
    include Mongoid::Timestamps

    field :uri,         type: String
    field :duration,    type: Integer

    belongs_to :playlist, class_name: 'Party::Playlist'
    belongs_to :user

    # TODO: We need to fetch data from youtube!!!

    def as_json options={}
      {
        id: id.to_s,
        uri: uri,
        duration: duration,
        created_at: created_at,
        updated_at: updated_at,
        user: user
      }
    end
  end
end
