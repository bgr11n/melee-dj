class PartiesController < ApplicationController
  before_action :find_user

  def show

  end

  private

  def find_user
    @user = User.where(nickname: params[:nickname]).first || not_found
  end
end
