require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'
require 'webmock/rspec'
WebMock.allow_net_connect!
require 'capybara/email/rspec'
require 'cancan/matchers'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
Dir["#{Rails.root}/app/uploaders/*.rb"].each { |file| require file }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include Devise::Test::ControllerHelpers, type: :controller

  config.extend ControllerMacros, type: :controller
  config.include OmniauthMacros

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  OmniAuth.config.test_mode = true

  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.after(:all) do
    FileUtils.rm_rf(Dir["#{Rails.root}/spec/support/uploads"]) if Rails.env.test?
  end
end
