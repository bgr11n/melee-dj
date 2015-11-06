require 'faye'
require File.expand_path('../config/initializers/faye_token.rb', __FILE__)

class ServerAuth
  def incoming message, callback
    if message['channel'] !~ %r{^/meta/}
        message['error'] = 'Invalid auth token.' if !message['ext'] || message['ext']['auth_token'] != FAYE_TOKEN
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

Faye::WebSocket.load_adapter('thin')

faye_server = Faye::RackAdapter.new(mount: '/faye', timeout: 25)
faye_server.add_extension(ServerAuth.new)
run faye_server
