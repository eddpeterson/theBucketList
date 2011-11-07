if Rails.env.production?
  FACEBOOK_APP_ID = ENV['facebook_app_id']
  FACEBOOK_APP_SECRET = ENV['facebook_app_secret'] 
else
  app_config = YAML.load_file(Rails.root.join('config', 'config.yml'))[ENV["RAILS_ENV"]]
  FACEBOOK_APP_ID = app_config['facebook_app_id']
  FACEBOOK_APP_SECRET = app_config['facebook_app_secret']
end