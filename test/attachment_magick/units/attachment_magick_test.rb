require 'test_helper'
require 'open-uri'

class AttachmentMagickTest < ActiveSupport::TestCase

  class Dog
    include Mongoid::Document
    include AttachmentMagick

    field :name

    attachment_magick do
      grid_1
    end
  end

  class Cat
    include Mongoid::Document
    include AttachmentMagick

    field :name

    attachment_magick do
      grid_1 "300x150"
      grid_7 "x560>"
    end
  end

  test "deveria manter o valor do grid original" do
    assert_equal "300x150", Cat.style_grid_1
    assert_equal "x560>",   Cat.style_grid_7
    assert_equal "54x",     Dog.style_grid_1
  end

  def test_has_attachment_magick
    grids = Artist.send(:generate_grids)

    Artist.attachment_magick do
      grid_1
      grid_5  "120x240"
      grid_7  :height => 200
      grid_10 :height => 200, :width => 100
    end

    assert_equal [:grid_1, :grid_5, :grid_7, :grid_10], order_array(Artist.attachment_magick_default_options[:styles].keys)

    assert_equal grids[:grid_1][:width],  Artist.attachment_magick_default_options[:styles][:grid_1][:width]
    assert_equal grids[:grid_1][:height], Artist.attachment_magick_default_options[:styles][:grid_1][:height]

    assert_equal 120,                     Artist.attachment_magick_default_options[:styles][:grid_5][:width]
    assert_equal 240,                     Artist.attachment_magick_default_options[:styles][:grid_5][:height]

    assert_equal grids[:grid_7][:width],  Artist.attachment_magick_default_options[:styles][:grid_7][:width]
    assert_equal 200,                     Artist.attachment_magick_default_options[:styles][:grid_7][:height]

    assert_equal 100,                     Artist.attachment_magick_default_options[:styles][:grid_10][:width]
    assert_equal 200,                     Artist.attachment_magick_default_options[:styles][:grid_10][:height]
  end

  def test_generate_grids
    column_width  = 29
    column_amount = 10
    gutter        = 3

    grid_system = open("http://www.spry-soft.com/grids/grid/?column_width=#{column_width}&column_amount=#{column_amount}&gutter_width=#{gutter}") { |url| Hpricot(url) }
    grids       = Artist.send(:generate_grids, column_amount, column_width, gutter)

    assert_equal grids.size, column_amount + AttachmentMagick.configuration.custom_styles.styles.size

    grids.keys.each do |key|
      assert_equal grids[key][:width],  grid_system.search(".#{key} p").first.inner_html.gsub(/\D/, "").to_i if key.to_s.include?("grid")
    end
  end

  def test_setup
    AttachmentMagick.setup do |config|
      config.columns_amount = 19
      config.columns_width  = 54
      config.gutter         = 3

      config.custom_styles do
        small "36x46"
        full  :width => 1024
      end
    end

    Artist.attachment_magick do
      small
      full
    end

    assert_equal 19,    AttachmentMagick.configuration.columns_amount
    assert_equal 54,    AttachmentMagick.configuration.columns_width
    assert_equal 3,     AttachmentMagick.configuration.gutter

    assert_equal 36,    Artist.attachment_magick_default_options[:styles][:small][:width]
    assert_equal 46,    Artist.attachment_magick_default_options[:styles][:small][:height]

    assert_equal 1024,  Artist.attachment_magick_default_options[:styles][:full][:width]
  end

  def test_setup_with_stylesheet
    assert_equal 19,  AttachmentMagick.configuration.columns_amount
    assert_equal 54,  AttachmentMagick.configuration.columns_width
    assert_equal 3,   AttachmentMagick.configuration.gutter

    AttachmentMagick.setup {|config| config.parse_stylesheet 'old_grid.css'}

    assert_equal 12,  AttachmentMagick.configuration.columns_amount
    assert_equal 60,  AttachmentMagick.configuration.columns_width
    assert_equal 10,  AttachmentMagick.configuration.gutter

    AttachmentMagick.setup {|config| config.parse_stylesheet 'grid.css'}

    assert_equal 19,  AttachmentMagick.configuration.columns_amount
    assert_equal 54,  AttachmentMagick.configuration.columns_width
    assert_equal 4,   AttachmentMagick.configuration.gutter

    AttachmentMagick.setup {|config| config.parse_stylesheet 'not_found.css'}

    assert_equal 19,  AttachmentMagick.configuration.columns_amount
    assert_equal 54,  AttachmentMagick.configuration.columns_width
    assert_equal 4,   AttachmentMagick.configuration.gutter
  end

  private

  def order_array(array)
    array.sort{|x, y| x.to_s.split("_")[1].to_i <=> y.to_s.split("_")[1].to_i}
  end
end