# Configure Rails Envinronment
begin
  require 'simplecov'
  SimpleCov.start('rails') do
    add_filter '/vendor/'
  end
rescue
end

ENV["RAILS_ENV"] = "test"

require 'ruby-debug' ; Debugger.start
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

ActionMailer::Base.delivery_method = :test
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_url_options[:host] = "test.com"

Rails.backtrace_cleaner.remove_silencers!

# Configure capybara for integration testing
require "capybara/rails"
Capybara.default_driver   = :rack_test
Capybara.default_selector = :css

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# For generators
require "rails/generators/test_case"
require "generators/attachment_magick/install_generator"
require "generators/attachment_magick/migration_generator"

# Some helpers
require "attachment_magick/test/attachment_magick_test_helper"

class ActiveSupport::TestCase
  include AttachmentMagickTestHelper
end

class ActionController::TestCase
  include AttachmentMagickTestHelper
end

class ActionView::TestCase
  include AttachmentMagickTestHelper
end