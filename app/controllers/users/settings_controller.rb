module Users
  class SettingsController < ApplicationController

    def index
      build_user
    end

    def update
      build_user
      save_user || render('index')
    end

    private

    def build_user
      @user ||= User.find current_user.id
      @user.attributes = user_params
    end

    def save_user
      redirect_to root_url if @user.save
    end

    def user_params
      params[:user] ? params[:user].permit(:email, :nickname) : {}
    end
  end
end
