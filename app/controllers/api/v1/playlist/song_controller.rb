module Api::V1::Playlist
  class SongController < Api::ApiController

    def create
      fetch_track
      find_playlist
      build_song
      save_song || render(json: { success: false })
    end

  private
    def fetch_track
      track = Track.find_or_create_by uri: song_params[:uri]
      track.update_info song_params
    end

    def find_playlist
      @dj = User.includes(party: :playlist).find_by(nickname: params[:nickname]) || not_found
      byebug
      @playlist = @dj.party.playlist
    end

    def build_song
      @song ||= ::Playlist::Song.new add_params.merge(track_uri: song_params[:uri])
    end

    def save_song
      bloadcast_song if @song.save
    end

    def bloadcast_song
      FayeClient::Broadcaster.publish "/#{@dj.nickname}/playlist/songs/new", [@song]
      render json: { success: true }
    end

    def song_params
      return {} unless params[:song].present?
      params.require(:song).permit(:uri, :title, :thumbnail)
    end

    def add_params
      {
        playlist_id: @playlist.id,
        user_id: current_user.id
      }
    end
  end
end
