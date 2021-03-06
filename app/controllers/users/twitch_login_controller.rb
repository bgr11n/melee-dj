require 'twitch'

module  Users
  class TwitchLoginController < ApplicationController
    def callback
      redirect_to sign_in_path, flash: { warning: 'Something went wrong.' } and return if !token || !user_data['email']
      build_user
      save_user_as_twitch or redirect_to sign_in_path, flash: { warning: @user.errors.full_messages.join("<br>") }
    end

    private

    def token
      @token ||= Twitch::Auth.new(params[:code]).token['access_token']
    end

    def build_user
      @user ||= User::AsTwitchLogin.fetch_or_create user_data
    end

    def user_data
      @user_data ||= Twitch::Users.new(token).user
    end

    def save_user_as_twitch
      log_in_user if @user.save
    end
  end
end
