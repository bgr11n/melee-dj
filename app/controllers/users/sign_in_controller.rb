module Users
  class SignInController < ApplicationController
    before_action :redirect_if_signed_in, except: [:destroy]

    def new
      build_sign_in
      p @user
    end

    def create
      build_sign_in
      save_sign_in || render('new')
    end

    def destroy
      reset_session
      redirect_to root_url, flash: { info: 'Signed out!' }
    end

    private

    def build_sign_in
      @sign_in ||= User::AsSignIn.new(sign_in_params)
      @user ||= @sign_in.user
    end

    def save_sign_in
      log_in_user if @sign_in.save
    end

    def sign_in_params
      params[:user_as_sign_in].permit(:email, :password) if params[:user_as_sign_in]
    end
  end
end
