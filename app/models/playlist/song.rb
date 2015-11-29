module Playlist
  class Song
    include Mongoid::Document
    include Mongoid::Timestamps

    field :uri, type: String

    belongs_to :playlist, class_name: 'Party::Playlist'
    belongs_to :user
  end
end
