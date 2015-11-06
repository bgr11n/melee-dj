require "net/http"

module UsersHelper

  # def broadcast channel, data
  #   message = { channel: channel, data: data, ext: { auth_token: FAYE_TOKEN } }
  #   body = { message: message }
  #   uri = URI.parse("http://localhost:9292/faye")
  #   Net::HTTP.post_form(uri, :message => message.to_json)
  #   HTTParty.post(uri, body: { :message => message }.to_json)
  # end

  def current_user
    @current_user ||= User.find session[:user_id] if session[:user_id].present?
  end

  def user_signed_in?
    current_user.present?
  end
end
