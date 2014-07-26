require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'webmock/rspec'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  # Checks for pending migrations before tests are run.
  # If you are not using ActiveRecord, you can remove this line.
  ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

  RSpec.configure do |config|
    config.use_transactional_fixtures = false

    config.infer_base_class_for_anonymous_controllers = false

    config.order = "random"

    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:deletion)
    end

    config.before(:each) do
      DatabaseCleaner.strategy = example.metadata[:type] == :feature ? :deletion : :transaction
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

    config.before(:all) do
      WebMock.disable_net_connect! :allow_localhost => true
    end

    config.after(:all, type: :request) do
      WebMock.disable_net_connect! :allow_localhost => false
    end

  end
end

Spork.each_run do
  FactoryGirl.reload
end