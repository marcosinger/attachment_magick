require 'test_helper'
require 'open-uri'

class AttachmentMagickTest < ActiveSupport::TestCase
  #FIXME Retirar essa class
  class Robocop
    extend AttachmentMagick
  end

  def test_has_attachment_magick
    grids = Robocop.generate_grids

    Robocop.attachment_magick do
      grid_1
      grid_5 "120x240"
      grid_7 :height => 200
      grid_10 :height => 200, :width => 100
    end
    
    assert_equal [:grid_1, :grid_5, :grid_7, :grid_10], Robocop.attachment_magick_default_options[:styles].keys

    assert_equal grids[:grid_1][:width],                Robocop.attachment_magick_default_options[:styles][:grid_1][:width]
    assert_equal grids[:grid_1][:height],               Robocop.attachment_magick_default_options[:styles][:grid_1][:height]

    assert_equal 120,                                   Robocop.attachment_magick_default_options[:styles][:grid_5][:width]
    assert_equal 240,                                   Robocop.attachment_magick_default_options[:styles][:grid_5][:height]

    assert_equal grids[:grid_7][:width],                Robocop.attachment_magick_default_options[:styles][:grid_7][:width]
    assert_equal 200,                                   Robocop.attachment_magick_default_options[:styles][:grid_7][:height]

    assert_equal 100,                                   Robocop.attachment_magick_default_options[:styles][:grid_10][:width]
    assert_equal 200,                                   Robocop.attachment_magick_default_options[:styles][:grid_10][:height]
  end
  
  #FIXME Valores das variáveis devem ser aleatórios
  def test_generate_grids
    column_width  = 29
    column_amount = 10
    gutter        = 3
    
    grid_system = open("http://www.spry-soft.com/grids/grid/?column_width=#{column_width}&column_amount=#{column_amount}&gutter_width=#{gutter}") { |url| Hpricot(url) }
    grids       = Robocop.generate_grids(column_amount, column_width, gutter)
    
    assert_equal grids.size, column_amount
    
    grids.keys.each do |key|
      assert_equal grids[key][:width],  grid_system.search(".#{key} p").first.inner_html.gsub(/\D/, "").to_i
    end  
  end
end
