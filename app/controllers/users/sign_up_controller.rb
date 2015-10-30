module Users
  class SignUpController < ApplicationController
    before_action :redirect_if_signed_in

    def new
      build_user
    end

    def create
      build_user
      user_save or render 'new'
    end

    private

    def build_user
      @user ||= User::AsSignUp.new(user_params)
    end

    def user_save
      log_in_user if @user.save
    end

    def user_params
      user_params = params[:user]
      user_params.permit(:email, :password, :password_confirmation) if user_params
    end
  end
end
