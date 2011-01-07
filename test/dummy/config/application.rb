require File.expand_path('../boot', __FILE__)

require "active_model/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "action_mailer/railtie"

Bundler.require
require "attachment_magick"

module Dummy
  class Application < Rails::Application
    config.encoding           = "utf-8"
    config.filter_parameters  += [:password]
    
    config.middleware.insert_after 'Rack::Lock', 'Dragonfly::Middleware', :images, '/media'
    config.middleware.insert_before 'Dragonfly::Middleware', 'Rack::Cache', {
      :verbose     => true,
      :metastore   => "file:#{Rails.root}/tmp/dragonfly/cache/meta",
      :entitystore => "file:#{Rails.root}/tmp/dragonfly/cache/body"
    }
  end
end
