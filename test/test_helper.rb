ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  FactoryBot.reload

<<<<<<< HEAD
  Faker::Config.locale = 'en-US'
=======
  FFaker::Locale.code 'en-US'
>>>>>>> 81f1f12cb6be2f93e4bdb0be295d2865f63f0c8e

  # load Hotel and Race data?
  # load "#{Rails.root}/db/seeds/base.rb"

  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  # Add more helper methods to be used by all tests here...
end
