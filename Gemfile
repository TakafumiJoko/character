source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails',                      '6.0.3'
gem 'puma',                       '4.3.4'
gem 'sass-rails',                 '5.1.0'
gem 'webpacker',                  '4.0.7'
gem 'bootsnap',                   '1.4.5', require: false
gem 'faker',                      '2.1.2'    
gem 'will_paginate',              '3.1.8'
gem 'will_paginate-bootstrap4',   '0.2.2'
gem 'bcrypt',                     '3.1.13'
gem 'image_processing',           '1.11.0'
gem 'active_storage_validations', '0.8.2'
gem 'bootstrap_form',             '4.5.0'
gem 'bootstrap',                  '4.5.2'
gem 'jquery-rails',               '4.4.0'
gem 'pry-rails',                  '0.3.9'

group :development, :test do
  gem 'sqlite3',           '1.4.1'
  gem 'rspec-rails',       '4.0.1'
  gem 'factory_bot_rails', '6.1.0'
end

group :development do
  gem 'web-console',           '4.0.1'
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.1.0'
  gem 'spring-watcher-listen', '2.0.1'
  gem 'spring-commands-rspec', '1.0.4'
end

group :test do
  gem 'capybara',   '3.28.0'
  gem 'launchy',    '2.5.0'
  gem 'webdrivers', '4.1.2'
end

group :production do
  gem 'pg',         '1.1.4'
  gem 'aws-sdk-s3', '1.46.0', require: false
end

# Windows ではタイムゾーン情報用の tzinfo-data gem を含める必要があります
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]