source "https://rubygems.org"

gem "rails", "4.1.8"

gem "unicorn"

gem 'pg'

gem 'bootstrap-sass', '~> 3.3.4'
gem 'sass'

gem 'therubyracer'

# NOTE: If you use PostgreSQL, you must still leave enabled the above mysql2
# gem for Sphinx full text search to function.

# gem "thinking-sphinx", "~> 3.1.2"

gem "uglifier", ">= 1.3.0"
gem "jquery-rails"
gem "dynamic_form"

gem "exception_notification"

gem "bcrypt", "~> 3.1.2"

gem "nokogiri", "= 1.6.1"
gem "htmlentities"
gem "rdiscount"

# for twitter-posting bot
gem "oauth"

# for parsing incoming mail
gem "mail"

# Background jobs
gem 'sidekiq'

# Check remote images metadata
gem 'fastimage'

# Images
gem 'carrierwave'

# Processing library
gem 'mini_magick'

# OpenURI patch to allow redirections between HTTP and HTTPS
gem 'open_uri_redirections'

# Rails observer (removed from core in Rails 4.0)
gem 'rails-observers'

# Postgres full text search
gem 'pg_search'

# Pagination
gem 'kaminari'

# Markdown parser
gem 'redcarpet'

group :development do
  gem 'mina'
  gem 'mina-multistage'
end

group :test, :development do
  gem "rspec-rails", "~> 2.6"
  gem "machinist"
  gem "sqlite3"
  gem "faker"
end
