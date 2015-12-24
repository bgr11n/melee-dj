Youtube.api_key = YAML.load_file("#{::Rails.root}/config/youtube.yml")[Rails.env]['api_key']
p '=========================='
p Youtube.api_key
p '=========================='
