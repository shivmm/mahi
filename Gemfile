source 'https://rubygems.org'

RAILS_VERSION = '~> 3.2.6'
DM_VERSION    = '~> 1.2.0'

gem 'activesupport',  RAILS_VERSION, :require => 'active_support'
gem 'actionpack',     RAILS_VERSION, :require => 'action_pack'
gem 'actionmailer',   RAILS_VERSION, :require => 'action_mailer'
gem 'activeresource', RAILS_VERSION, :require => 'active_resource'
gem 'railties',       RAILS_VERSION, :require => 'rails'
gem 'tzinfo',         '~> 0.3.32'

gem 'dm-rails',               '~> 1.2.1'
gem 'therubyracer'
gem 'dm-devise'
# You can use any of the other available database adapters.
# This is only a small excerpt of the list of all available adapters
# Have a look at
#
#  http://wiki.github.com/datamapper/dm-core/adapters
#  http://wiki.github.com/datamapper/dm-core/community-plugins
#
# for a rather complete list of available datamapper adapters and plugins

# gem 'dm-sqlite-adapter',    DM_VERSION
# gem 'dm-mysql-adapter',     DM_VERSION
gem 'dm-postgres-adapter',  DM_VERSION
# gem 'dm-oracle-adapter',    DM_VERSION
# gem 'dm-sqlserver-adapter', DM_VERSION

gem 'dm-migrations',   DM_VERSION
gem 'dm-types',        DM_VERSION
gem 'dm-validations',  DM_VERSION
gem 'dm-constraints',  DM_VERSION
gem 'dm-transactions', DM_VERSION
gem 'dm-aggregates',   DM_VERSION
gem 'dm-timestamps',   DM_VERSION
gem 'dm-observer',     DM_VERSION


gem 'cancan', :git => 'https://github.com/ryanb/cancan.git', :branch => '2.0'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.5'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier',     '~> 1.2.4'
  gem "twitter-bootstrap-rails"
  gem 'less'
end

gem 'jquery-rails', '~> 2.0.1'
gem 'haml-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.1'

# Use unicorn as the web server
# gem 'unicorn', '~> 4.2.1'

# Deploy with Capistrano
# gem 'capistrano', '~> 2.11.2'

# To use debugger
# gem 'ruby-debug19', '~> 0.11.6', :require => 'ruby-debug'

#group :test do
  # Pretty printed test output
 #end

group :test, :development do
  gem "rspec-rails", "~> 2.0"
  gem 'rspec'
  gem 'dm-rspec2'
  gem 'turn', '~> 0.9.4', :require => false
  gem 'debugger'
  gem 'factory_girl'
  gem 'awesome_print'
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'capybara'
  #gem 'capybara-webkit'
 
end




