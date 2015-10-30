module Users
  class SettingsController < ApplicationController

    def index
      build_user
    end

    def update
      build_user
      if @user.save
        redirect_to root_url
      else
        render 'index'
      end
    end

    private

    def build_user
      @user ||= current_user
      @user.attributes = user_params
    end

    def user_params
      params[:user] ? params[:user].permit(:email, :nickname) : {}
    end
  end
end
