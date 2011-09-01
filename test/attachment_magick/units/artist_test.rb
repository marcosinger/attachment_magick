require 'test_helper'

class ArtistTest < ActiveSupport::TestCase
  def test_access_grid_method
    assert_equal "36x36",     Artist.style_thumb
    assert_equal "54x",       Artist.style_grid_1
    assert_equal "150x",      Artist.style_grid_10
    assert_equal "200x300",   Artist.style_grid_15
    assert_equal "909x230#",  Artist.style_grid_16
    assert_equal "x700>",     Artist.style_portrait
  end

  def test_image_cover
    @artist = Artist.create(:name => "Busk")
    @image = @artist.images.create(:photo => exemple_file, :priority => 0)
    @artist.images.create(:photo => exemple_file, :priority => 1)

    assert_equal @artist.image_cover, @image
  end
end