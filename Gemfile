source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'bcrypt', '~> 3.1.7'
gem 'bootstrap', '~> 4.0.0.beta'
gem 'bootstrap-social-rails'
gem 'bootstrap4-kaminari-views'
gem 'cancancan'
gem 'capybara-email'
gem 'carrierwave'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'font-awesome-rails'
gem 'friendly_id', '~> 5.1.0'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'json_spec'
gem 'kaminari'
gem 'oj'
gem 'oj_mimic_json'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'omniauth-vkontakte'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'
gem 'rails-controller-testing'
gem 'ransack', github: 'activerecord-hackery/ransack'
gem 'redis', '~> 3.0'
gem 'responders', '~> 2.0'
gem 'rest-client'
gem 'rubocop', require: false
gem 'sass-rails', '~> 5.0'
gem 'sidekiq'
gem 'sinatra', '>= 1.3.0', require: nil
gem 'slim-rails'
gem 'sprockets-rails'
gem 'therubyracer', platforms: :ruby
gem 'turbolinks', '~> 5'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'uglifier', '>= 1.3.0'
gem 'webmock'
gem 'whenever'

group :development do
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'launchy'
  gem 'shoulda-matchers', '~> 3.1'
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end
