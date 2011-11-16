if Rails.env.production?
  FACEBOOK_APP_ID = ENV['facebook_app_id']
  FACEBOOK_APP_SECRET = ENV['facebook_app_secret'] 
else
  app_config = YAML.load_file(Rails.root.join('config', 'config.yml'))[ENV["RAILS_ENV"]]
  if app_config.nil?
    puts "...................................."
    puts "Missing config.yml to load facebook app id and secret for this application"
    puts "...................................."
    FACEBOOK_APP_ID = "UNDEFINED"
    FACEBOOK_APP_SECRET = "UNDEFINED"
  else
    FACEBOOK_APP_ID = app_config['facebook_app_id']
    FACEBOOK_APP_SECRET = app_config['facebook_app_secret']
  end
end