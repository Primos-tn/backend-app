ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'devise'

# include all files in spec support
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }


class ActiveSupport::TestCase
  # table name is "brands_stores". It is being mapped to model "BrandStore".
  # self.set_fixture_class brands_stores: BrandStore

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
