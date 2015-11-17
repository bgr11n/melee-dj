require 'faye'
require './lib/faye_client'

Faye::WebSocket.load_adapter('thin')

faye_server = Faye::RackAdapter.new(mount: '/faye', timeout: 25)
faye_server.add_extension(FayeClient::Authenticator.new(ENV['RACK_ENV']))

run faye_server
