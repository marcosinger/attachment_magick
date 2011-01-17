module AttachmentMagick
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def copy_initializer
        directory "public/"
        route "post 'publisher/images', :to => 'publisher/images#create'"
        route "post 'publisher/images/update_sortable', :to => 'publisher/images#update_sortable'"
        route "delete 'publisher/images/:id/:klass/:klass_id',  :to => 'publisher/images#destroy'"
      end
    end
  end
end