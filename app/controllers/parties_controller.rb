class PartiesController < ApplicationController
  before_action :find_user
  before_action :authenticate!

  def show

  end

  def create

  end

  private

  def find_user
    @user = User.where(nickname: params[:nickname]).first || not_found
  end
end
