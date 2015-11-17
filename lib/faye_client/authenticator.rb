require 'yaml'

module FayeClient
  class Authenticator
    def initialize environment
      @faye = YAML.load_file("config/faye.yml")[environment]
    end

    def incoming message, callback
      p '=============================='
      p message
      p '=============================='
      if message['channel'] !~ %r{^/meta/}
        if !message['ext'] || message['ext']['auth_token'] != @faye['auth_token']
          message['error'] = 'Invalid auth token.'
        end
      end
      callback.call(message)
    end

    def outgoing message, callback
      if message['ext'] && message['ext']['auth_token']
        message['ext'] = {}
      end
      callback.call(message)
    end
  end
end
