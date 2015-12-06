module Parties
  class SongsController < ApplicationController
    before_action :authenticate!
    before_action :find_playlist

    def create
      build_song
      save_song || render(json: { success: false })
    end

    def index
      # MB we don't need this
      render json: { songs: @playlist.songs }
    end

  private

    def build_song
      @song ||= Playlist::Song.new song_params.merge(user_id: current_user.id, playlist_id: @playlist.id)
    end

    def save_song
      bloadcast_song if @song.save
    end

    def bloadcast_song
      FayeClient::Broadcaster.publish "/#{@dj.nickname}/party/playlist/songs/new", [@song]
      render json: { status: :ok }
    end

    def find_playlist
      @playlist = Party::Playlist.includes(:songs, :party).find(params[:playlist_id]) || not_found
      @dj = @playlist.party.user
    end

    def song_params
      params[:playlist_song] ? params[:playlist_song].permit(:uri) : {}
    end
  end
end
