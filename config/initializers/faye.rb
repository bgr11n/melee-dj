Rails.application.config.faye = YAML.load_file("#{::Rails.root}/config/faye.yml")[Rails.env]
