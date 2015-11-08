class Party
  class Playlist
    include Mongoid::Document
    include Mongoid::Timestamps

    belongs_to :party
  end
end
