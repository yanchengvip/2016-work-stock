source 'https://gems.ruby-china.org'

gem 'rails', '4.2.2'

# db
#gem 'pg'
#gem 'activerecord-postgis-adapter', '~>3.0.0'
gem 'mysql2', '~> 0.3.18'
gem 'kaminari'
gem 'uuidtools'

gem 'hiredis'
gem 'redis', :require => ["redis/connection/hiredis", "redis"]
gem 'redis-objects'
gem 'redis-rails'

gem 'qiniu'

# assets
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'materialize-sass', '~>0.97.5'
gem 'font-awesome-rails'
gem 'fancybox2-rails', '~> 0.2.8'
# gem "autoprefixer-rails"

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# sms
gem 'cloopen'
gem 'ali_dayu'

gem 'settingslogic', '~> 2.0.0'

gem 'pickup'

gem 'faraday'

gem 'httparty', '~> 0.13.7'
#gem 'oneapm_rpm'

group :development, :test do
  gem 'pry-rails',  '0.3.2'
  gem 'pry-nav',    '0.2.4'
  gem 'pry-stack_explorer', '0.4.9.1'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.2.1'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'capistrano', '~> 3.4.0'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rvm', '~> 0.1.2'
  gem 'capistrano3-unicorn', '~> 0.2.1'
  gem 'capistrano-rails-collection', '~> 0.0.3'
  gem 'capistrano-faster-assets', '~> 1.0'

  gem 'guard-livereload', '~> 2.4', require: false
  gem 'annotate', ">=2.6.0"
end

group :production do
  # Use Unicorn as the app server
  gem 'unicorn'
end
