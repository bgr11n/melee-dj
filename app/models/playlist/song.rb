module Playlist
  class Song
    include Mongoid::Document
    include Mongoid::Timestamps

    field :active,                     type: Boolean,                         default: true

    belongs_to :track,                 foreign_key: :track_uri,               primary_key: :uri
    belongs_to :playlist,              class_name: 'Party::Playlist'
    belongs_to :user

    index({ track_uri: 1 }, { unique: true })

    default_scope ->{ order_by(created_at: :asc) }

    def as_json options={}
      {
        id: id.to_s,
        created_at: created_at,
        updated_at: updated_at,
        user: user,
        track: track
      }
    end
  end
end
