if Rails.env.production? == false
  APP_CONFIG = YAML.load_file(Rails.root.join('config', 'config.yml'))[ENV["RAILS_ENV"]]
end