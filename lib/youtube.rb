module Youtube
  cattr_accessor :api_key
end

Dir[File.join(File.dirname(__FILE__), "youtube/*.rb")].each { |f| require f }
