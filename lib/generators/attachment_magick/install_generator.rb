module AttachmentMagick
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def copy_initializer
        directory "public/"
        route "match '/media/*dragonfly', :to => Dragonfly[:images]"
        route "post 'attachment_magick/images', :to => 'attachment_magick/images#create'"
        route "post 'attachment_magick/images/update_sortable', :to => 'attachment_magick/images#update_sortable'"
        route "delete 'attachment_magick/images/:id/:data_attachment',  :to => 'attachment_magick/images#destroy'"
      end
    end
  end
end