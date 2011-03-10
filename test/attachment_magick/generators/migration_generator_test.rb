require 'test_helper'

class MigrationGeneratorTest < Rails::Generators::TestCase
  tests       AttachmentMagick::Generators::MigrationGenerator
  destination File.expand_path("../../tmp", __FILE__)

  setup do
    prepare_destination
  end

  test "Assert all files are properly created" do
    run_generator

    assert Dir["#{File.expand_path("../../tmp", __FILE__)}/**/*.rb"].first.include?("attachment_magick_migration.rb")
  end
end