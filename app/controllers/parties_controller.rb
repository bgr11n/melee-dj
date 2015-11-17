require 'faye_client'

class PartiesController < ApplicationController
  before_action :find_user
  before_action :authenticate!

  def show
  end

  private

  def find_user
    @user ||= User.where(nickname: params[:nickname]).first || not_found
    @party ||= @user.party || render('errors/no_party')
  end
end
