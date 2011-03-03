require "test_helper"

class AttachmentMagick::AttachmentMagickHelperTest < ActionView::TestCase
  setup do
    create_artist
    create_work(@artist)
  end

  def test_attachment_progress_container
    html = attachment_progress_container(@artist)
    assert        assert_element_in(html, "div[@id='attachmentProgressContainer']")
    assert        assert_element_in(html, "span[@id='attachmentButton']")
    assert        assert_element_in(html, "input[@id='attachmentmagick_key']")
    assert_equal  "Artist_#{@artist.id}", assert_element_value(html, "input[@id='attachmentmagick_key']", "data_attachment")

    html = attachment_progress_container(@artist.works.first)
    assert        assert_element_in(html, "div[@id='attachmentProgressContainer']")
    assert        assert_element_in(html, "span[@id='attachmentButton']")
    assert        assert_element_in(html, "input[@id='attachmentmagick_key']")
    assert_equal  "Artist_#{@artist.id}_works_#{@artist.works.first.id}", assert_element_value(html, "input[@id='attachmentmagick_key']", "data_attachment")
  end

  def test_attachment_for_view
    html = attachment_for_view(@artist)
    assert assert_element_in(html, "a[@class='remove_image']")
    assert assert_element_in(html, "input[@id='image_id']")

    html = attachment_for_view(@artist, exemple_partial)
    assert assert_element_in(html, "div[@class='image_caption']")
    assert assert_element_in(html, "div[@class='image_thumb']")
    assert assert_element_in(html, "img")
  end
end
