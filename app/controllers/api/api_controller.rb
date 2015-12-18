class Api::ApiController < ActionController::Base
  include UsersHelper
  before_action :authenticate!

private

  def authenticate!
    render json: { error: 'Unauthorized' }, status: 401 unless user_signed_in?
  end

  def not_found msg = ''
    render json: { error: "Not found #{msg}" }, status: 404
  end
end
