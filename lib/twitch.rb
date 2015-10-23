module Twitch ; end
Dir[File.join(File.dirname(__FILE__), "twitch/*.rb")].each { |f| require f }
