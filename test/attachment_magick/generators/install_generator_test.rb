require File.join(File.dirname(__FILE__), '..', '..', 'test_helper')

class InstallGeneratorTest < Rails::Generators::TestCase
  tests       AttachmentMagick::Generators::InstallGenerator
  destination File.expand_path("../../tmp", __FILE__)
  setup       :prepare_destination

  test "Assert all files are properly created" do
    run_generator
    
    assert_file "public/javascripts/swfupload/handlers.js"
    assert_file "public/javascripts/swfupload/swfupload.js"
    assert_file "public/javascripts/swfupload/swfupload.swf"
    assert_file "public/stylesheets/swfupload.css"
    assert_file "public/stylesheets/attachment_magick.css"
  end
end