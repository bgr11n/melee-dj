module Api::V1::Playlist
  class SongsController < Api::ApiController

    def index
      find_playlist
      render json: @playlist.songs
    end

    def create
      build_queue
      @song = @queue.add uri: song_params[:uri], user_id: current_user.id
      save_queue || render(json: @queue.errors.merge({ success: false })
      # find_playlist
      # fetch_track
      # build_song
      # save_song || render(json: { success: false })
    end

  private

    def build_queue
      @queue ||= Playlist::Queue.new playlist_id: @playlist.id
    end

    def save_queue
      bloadcast_song if @queue.save
    end

    def bloadcast_song
      FayeClient::Broadcaster.publish "/#{@dj.nickname}/playlist/songs/new", [@song]
      render json: { success: true }
    end

    def fetch_track
      track = Track.find_or_create_by uri: song_params[:uri]
      track.update_info song_params
    end

    def find_playlist
      @dj = User.includes(:party)
                .includes(:playlist, from: :party)
                .find_by(nickname: params[:nickname]) || not_found('dj')
      @playlist = @dj.party.playlist
    end

    # def build_song
    #   @song ||= ::Playlist::Song.new add_params.merge(track_uri: song_params[:uri])
    # end

    # def save_song
    #   bloadcast_song if @song.save
    # end

    # def bloadcast_song
    #   FayeClient::Broadcaster.publish "/#{@dj.nickname}/playlist/songs/new", [@song]
    #   render json: { success: true }
    # end

    def song_params
      return {} unless params[:song].present?
      params.require(:song).permit(:uri, :title, :thumbnail)
    end

    # def add_params
    #   {
    #     playlist_id: @playlist.id,
    #     user_id: current_user.id
    #   }
    # end
  end
end
