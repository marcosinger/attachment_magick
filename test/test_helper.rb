# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"

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

class ActionController::TestCase
  def assert_element_in(target, match)
    target = Hpricot(target)
    assert !target.search(match.to_s).empty?
  end
  
  def create_artist(options={})
    default_options = {:name => "Johnny", :lastname => "Depp"}
    default_options.merge!(options)
    
    @artist = Artist.create(default_options)
    @artist.images.create(:photo => exemple_file)
    
    @artist
  end

  def exemple_file
    File.expand_path('../dummy/public/images/little_girl.jpg', __FILE__)
  end
end

#FIXME Nada DRY!
class ActionView::TestCase
  def assert_element_in(target, match)
    target = Hpricot(target)
    assert !target.search(match.to_s).empty?
  end
  
  def create_artist(options={})
    default_options = {:name => "Johnny", :lastname => "Depp"}
    default_options.merge!(options)
    
    @artist = Artist.create(default_options)
    @artist.images.create(:photo => exemple_file)
    
    @artist
  end

  def exemple_file
    File.expand_path('../dummy/public/images/little_girl.jpg', __FILE__)
  end
end