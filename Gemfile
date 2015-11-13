source 'https://rubygems.org'

#HEROKU
group :production do
  gem 'rails_12factor' #necesario para Heroku
end
ruby "2.2.2" #especifica la versión de ruby a usar en Heroku.

# Gema para la autenticación con google
gem "omniauth-google-oauth2", "~> 0.2.1"
gem 'capybara'
#Google drive
gem 'google_drive', '1.0.1'

#Google Calendar
gem 'google-api-client', :require => 'google/api_client'
gem 'omniauth'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Compass
gem 'compass-rails', '~>2.0.5'
# Bootstrap
gem 'bootstrap-sass', '~> 3.3.5'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'responders', '~> 2.0'

gem 'cloudinary'

#Translate support in js
gem "i18n-js", ">= 3.0.0.rc11"


# Pagination
gem 'will_paginate'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  #gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # RSpec y Cocoverage
  gem 'simplecov'
  gem 'rspec-rails'

  #mock y stub
  gem 'rspec-activemodel-mocks'

  # Annotate
  gem 'annotate'

  # Use Capistrano for deployment
  gem 'capistrano-rails'

end

