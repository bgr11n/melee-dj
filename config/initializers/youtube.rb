Yt.configure do |config|
  config.api_key = YAML.load_file("#{::Rails.root}/config/youtube.yml")[Rails.env]['api_key']
  config.log_level = :debug if Rails.env.development?
end
