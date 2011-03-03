require 'test_helper'

class InstallGeneratorTest < Rails::Generators::TestCase
  tests       AttachmentMagick::Generators::InstallGenerator
  destination File.expand_path("../../tmp", __FILE__)

  setup do
    prepare_destination
    create_route_file
  end

  test "Assert all files are properly created" do
    run_generator

    assert_file "public/javascripts/swfupload/handlers.js"
    assert_file "public/javascripts/swfupload/swfupload.js"
    assert_file "public/javascripts/swfupload/swfupload.swf"
    assert_file "public/stylesheets/swfupload.css"
    assert_file "public/stylesheets/attachment_magick.css"

    assert_file "config/routes.rb" do |route|
      assert_match /'attachment_magick\/images#create'/,          route
      assert_match /'attachment_magick\/images#update_sortable'/, route
      assert_match /'attachment_magick\/images#destroy'/,         route
    end
  end

  private

  def create_route_file
    mkdir     File.join(InstallGeneratorTest.destination_root, 'config')
    copy_file File.join(InstallGeneratorTest.destination_root, '../../dummy/config/routes.rb'), File.join(InstallGeneratorTest.destination_root, 'config/routes.rb')
  end
end