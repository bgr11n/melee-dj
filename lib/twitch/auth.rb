module Twitch
  class Auth

    include HTTParty
    base_uri Settings.twitch.api_url

    attr_reader :code

    def initialize code
      @code = code
    end

    def token
      self.class.post '/oauth2/token', body: body
    end


    private

    def body
      {
        client_id: Settings.twitch.client_id,
        client_secret: Settings.twitch.client_secret,
        grant_type: 'authorization_code',
        redirect_uri: Settings.twitch.redirect_uri,
        code: code
      }
    end

  end
end
