source 'http://rubygems.org'

gem 'rails', '3.2.2'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'


group :assets do
  gem 'sass-rails',   '~> 3.2.5'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '>= 1.2.3'
end


gem 'jquery-rails', "~> 2.0.1"

gem "haml", "~> 3.1.4"

# gem 'mongo', '= 1.3.1' 
# gem 'bson', '= 1.3.1' 
# gem 'bson_ext', '= 1.3.1'
# gem "mongoid", "~> 2.0"
# gem "bson_ext", "~> 1.2"
gem "mongoid", "~> 2.3.3"
gem "activemodel", "~> 3.1"
gem "mongo", "~> 1.3"
gem "tzinfo", "~> 0.3.22"
gem "bson", "~> 1.3.1"
gem "bson_ext", "~> 1.3.1"

#gem "oa-oauth", "~> 0.3", :require => "omniauth/oauth"
#gem "omniauth", "~> 1.0"
gem "devise", "~> 1.5"
gem 'omniauth-facebook'

gem "rspec-rails", :group => [:test, :development]
gem 'simplecov', :require => false, :group => :test

#gem 'capybara', :git => 'git://github.com/jnicklas/capybara.git', :group => [:test, :development]
gem 'capybara', "~> 1.1", :group => [:test, :development]
gem 'launchy',  "~> 2.0", :group => [:test, :development]

gem 'exception_notification', "~> 2.5"
gem 'letter_opener', group: :development


group :development do
  gem "cheat"
end

group :test  do
  gem "database_cleaner"
  gem "factory_girl_rails"
  gem "shoulda"
  gem "guard-rspec"
  gem 'rb-fsevent'
  gem 'growl_notify'
  gem "timecop"
  gem 'mongoid-rspec'
end


# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

