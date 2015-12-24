class Playlist::Queue < PlainModel
  attr_accessor :playlist_id, :track_uri, :user_nickname

  validate :validate_repeating_track

  def playlist
    @playlist ||= Party::Playlist.find playlist_id
  end

  def track
    @track ||= Track.find track_uri
  end

  def user
    @user ||= User.find_by(nickname: params[:nickname])
  end

  def song
    @song ||= Playlist::Song.new playlist_id: playlist_id, user_id: user.id, track_uri: track_uri
  end

private

  def validate_repeating_track

  end
end
