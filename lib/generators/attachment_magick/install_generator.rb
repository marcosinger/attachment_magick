module AttachmentMagick
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def copy_initializer
        directory "public/"
        #create_file "swfupload/handlers.js",    "public/javascripts/swfupload/handlers.js"
        #create_file "swfupload/swfupload.js",   "public/javascripts/swfupload/swfupload.js"
        #create_file "swfupload/swfupload.swf",  "public/javascripts/swfupload/swfupload.swf"
      end
    end
  end
end