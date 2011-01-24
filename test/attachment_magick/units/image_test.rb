require File.expand_path('../../../test_helper', __FILE__)
 
class AttachmentMagick::ImageTest < ActiveSupport::TestCase
  def test_image
    assert_kind_of AttachmentMagick::Image, AttachmentMagick::Image.new
  end
  
  def test_create_thumb_for_vimeo_in_a_new_field
    @image = AttachmentMagick::Image.new(:source => 'http://vimeo.com/14074949')
    @image.save!

    assert_equal %'<iframe src=\"http://player.vimeo.com/video/14074949?title=0&byline=0&portrait=0\" width=\"620\" height=\"465\" frameborder=\"0\"></iframe>', @image.source_to_html
    assert_equal 'http://b.vimeocdn.com/ts/937/359/93735969_640.jpg', @image.source_to_image
  end
end