class Party
  class Playlist
    include Mongoid::Document
    include Mongoid::Timestamps

    belongs_to :party
    has_many :songs,          class_name: 'Playlist::Song'
  end
end
