ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

require 'capybara/rails'
require 'capybara/minitest'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  FactoryBot.reload

  FFaker::Locale.code "en-US"

  # load Hotel and Race data?
  # load "#{Rails.root}/db/seeds/base.rb"

  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  # Add more helper methods to be used by all tests here...
  include Devise::Test::IntegrationHelpers

  Capybara.default_max_wait_time = 4
  Capybara.disable_animation = true
end