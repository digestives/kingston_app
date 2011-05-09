source 'http://rubygems.org'

# gems and versions we want to use in our app
#
# Rspec for Rails 3
# http://relishapp.com/rspec/
#
gem 'rails', '3.0.7' # rails 3 latest
gem 'sqlite3' # to use with our sqlite3 database
gem 'sqlite3-ruby', '1.3.2', :require => 'sqlite3' # driver like JDBC
gem 'will_paginate', '3.0.pre2'

# for our development environment

group :development do
	# http://relishapp.com/rspec/rspec-rails
  gem 'rspec-rails', '2.5.0' # instead of rails test:unit 
  gem 'annotate-models' # inserts schema information into our models
  gem 'faker', '0.9.5' # generate fake information for tests
end

# only in our testing environment

group :test do
  gem 'rspec', '2.5.0' # rspec instead of test:unit
  gem 'webrat', '0.7.1' # for testing https://github.com/brynary/webrat
  gem 'factory_girl_rails', '1.0' # to test models
end

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19', :require => 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end
