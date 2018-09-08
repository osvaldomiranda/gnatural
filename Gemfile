source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.1'

# Better css sytanx
gem 'sass',  '~> 3.2.0'
#gem 'sass',  '~> 3.3.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'
#gem 'sass-rails', '~> 5.0.0'

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.1.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# For haml syntax
gem 'haml'

# For creating haml files when performing scaffold
gem 'haml-rails'

# Forms made easy
gem 'simple_form'

# Search
gem 'sunspot_rails'

gem 'sunspot_solr'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# For file upload
gem 'carrierwave'

# For remote file upload
gem 'fog'

# For image manipulation (crop, resize)
gem "mini_magick"

# For pagination
gem 'will_paginate'

# For authorization
gem 'cancan'

gem 'savon'

# For PostreSQL
gem 'pg', '~>0.17.1'

# for autentication
gem 'devise'

# for charts
gem "chartkick"
gem 'groupdate'

# for calendar
gem 'fullcalendar-rails'
gem 'momentjs-rails'

# for api planyo
gem 'rest-client'


#token para un modelo, en rails 5 no es necesaria la gema
gem 'has_secure_token'


group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  # Remote multi-server automation tool http://www.capistranorb.com
  gem 'capistrano', '~> 2.15.5'

  # Multiple stages deploy for capistrano
  gem 'capistrano-ext'

  # Pure Ruby implementation of an SSH (protocol 2) client 
  # http://net-ssh.github.com/net-ssh
  gem 'net-ssh', '~> 2.7.0'
end


group :production, :staging do
  # Use unicorn as the app server
  gem 'unicorn'
end

group :development, :staging do
  # For making rails console work
  gem 'rb-readline'
  # Console in error page
  gem 'binding_of_caller'

end
