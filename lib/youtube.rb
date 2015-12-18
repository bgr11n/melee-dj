module Youtube
  class << self
    attr_accessor :api_key
  end
end

Dir[File.join(File.dirname(__FILE__), "youtube/serializers/*.rb")].each { |f| require f }
Dir[File.join(File.dirname(__FILE__), "youtube/*.rb")].each { |f| require f }
