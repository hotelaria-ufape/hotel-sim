source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.1"

gem "rails", "~> 7.0.2", ">= 7.0.2.2"

gem "sprockets-rails"

gem "sqlite3", "~> 1.4"

gem "puma", "~> 5.0"

gem "importmap-rails"

gem "turbo-rails"

gem "stimulus-rails"

gem "jbuilder"

gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "cucumber-rails", require: false
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "database_cleaner"
end

group :production, :actions do
  gem 'pg'
  gem 'activerecord-postgresql-adapter'
end

gem 'cpf_cnpj', '~> 0.2.1'

gem 'semantic-ui-sass', '~> 2.2', '>= 2.2.1.1'
gem 'jquery-rails'