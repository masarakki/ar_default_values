ENV['RAILS_ENV'] = 'test'
require 'spec_helper'
require 'rspec/its'
require 'pry'
require 'coveralls'
Coveralls.wear!
require File.expand_path('../dummy/config/environment.rb',  __FILE__)
require 'rspec/rails'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

ActiveRecord::Migrator.migrations_paths = %w(db/migrate spec/dummy/db/migrate)
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end
