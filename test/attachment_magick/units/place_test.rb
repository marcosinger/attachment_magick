require 'test_helper'

class PlaceTest < ActiveSupport::TestCase
  def test_access_grid_method
    assert_equal "168x",  Place.style_grid_3
    assert_equal "54x",   Place.style_publisher
  end

  def test_image_cover
    @place = Place.create(:name => "Busk")
    @image = @place.images.create(:photo => example_file, :priority => 0)
    @place.images.create(:photo => example_file, :priority => 1)

    assert_equal @place.image_cover, @image
  end
end
