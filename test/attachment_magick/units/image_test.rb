require 'test_helper'

class AttachmentMagick::ImageTest < ActiveSupport::TestCase
  setup do
    create_artist
    create_place
  end

  def test_create_thumb_for_vimeo_in_a_new_field
    @artist_image = @artist.images.create({:source => 'http://vimeo.com/14074949'})
    @place_image  = @place.images.create({:source => 'http://vimeo.com/14074949'})

    assert_equal %'<iframe src=\"http://player.vimeo.com/video/14074949?title=0&byline=0&portrait=0\" width=\"620\" height=\"465\" frameborder=\"0\"></iframe>', @artist_image.source_to_html
    assert_equal 'http://b.vimeocdn.com/ts/937/359/93735969_640.jpg', @artist_image.source_to_image

    assert_equal %'<iframe src=\"http://player.vimeo.com/video/14074949?title=0&byline=0&portrait=0\" width=\"620\" height=\"465\" frameborder=\"0\"></iframe>', @place_image.source_to_html
    assert_equal 'http://b.vimeocdn.com/ts/937/359/93735969_640.jpg', @place_image.source_to_image
  end
end