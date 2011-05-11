require "attachment_magick"
require "rails"

module AttachmentMagick
  class Engine < Rails::Engine
    initializer 'attachment_magick.helper' do |app|
      ActionView::Base.send :include, AttachmentMagickHelper
    end

    initializer 'attachment_magick_dragonfly' do |app|
      require "attachment_magick/dragonfly/init"
    end
  end
end