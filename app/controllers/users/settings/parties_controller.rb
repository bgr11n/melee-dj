module Users
  module Settings
    class PartiesController < ApplicationController
      before_action :authenticate!
      before_action :edit_if_has_one, only: [:new, :create]

      def new
        build_party
      end

      def create
        build_party
        create_dependancy
        save_party || render('new')
      end

      def show
        build_party
      end

      def update
        build_party
        save_party || render('show')
      end

      private

      def build_party
        @party ||= User.find(current_user.id).party || Party.new(title: "My party", user_id: current_user.id)
        @party.attributes = user_params
      end

      def create_dependancy
        create_chat && create_playlist
      end

      def create_chat
        ::Party::Chat.create party_id: @party.id
      end

      def create_playlist
        ::Party::Playlist.create party_id: @party.id
      end

      def save_party
        redirect_to root_url if @party.save
      end

      def edit_if_has_one
        redirect_to settings_party_path if current_user.have_party?
      end

      def user_params
        params[:party] ? params[:party].permit(:title) : {}
      end
    end
  end
end
