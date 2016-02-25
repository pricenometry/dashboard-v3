source 'https://rubygems.org'

gem 'rails', '4.2.5'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'excon'
gem 'bootstrap-sass'
gem "chartkick"

gem 'devise'
gem 'pundit'

gem 'awesome_print'
gem 'progress'

# gem 'memcached'
# gem 'libmemcached_store', git: 'https://github.com/mojopages/libmemcached_store', ref: 'b5dce08'
gem 'haml'

gem 'google-analytics-rails'
gem 'sitemap_generator'
gem 'browser'

gem 'mina', :require => false
gem 'mina-unicorn', :require => false

group :assets do
  gem 'sass-rails', '~> 5.0'
  gem 'uglifier', '>= 1.3.0'
  gem 'coffee-rails', '~> 4.1.0'
end

group :development, :test do
  gem 'thin'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'teaspoon'
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'faker'
  gem 'sqlite3'
end

group :development do
  gem "rack-livereload"
  gem 'better_errors'
  gem 'binding_of_caller', platforms: [:mri_19, :mri_20, :rbx]
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rubocop', require: false
  gem 'spring-commands-rspec'
end

group :test do
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'selenium-webdriver'
  gem 'launchy'
  gem 'capybara'
  gem 'headless'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'guard-rails'
  gem 'simplecov', require: false
end

group :production do
  gem 'unicorn'
  gem 'pg'
  # gem 'pg_search'
  # gem "activerecord-postgres-hstore"
  gem 'rails_12factor'
end
