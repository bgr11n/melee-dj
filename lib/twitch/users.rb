module Twitch
  class Users

    include HTTParty
    base_uri Settings.twitch.api_url

    attr_reader :token

    def initialize token
      @token = token
    end

    def user
      self.class.get '/user', query: { oauth_token: token }
    end

  end
end
