require "attachment_magick"
require "rails"

module AttachmentMagick
  class Engine < Rails::Engine
    initializer 'attachment_magick.helper' do |app|
      ActionView::Base.send :include, AttachmentMagickHelper
    end
  end
end