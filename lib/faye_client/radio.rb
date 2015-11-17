require 'net/http'

module FayeClient
  class Broadcaster
    def self.publish channel, data
      message = { channel: channel, data: data.to_json, ext: { auth_token: Rails.application.config.faye['auth_token'] } }
      uri = URI.parse(Rails.application.config.faye['server'])
      Net::HTTP.post_form(uri, message: message.to_json)
    end
  end
end
