require File.expand_path('../../../test_helper', __FILE__)
require File.expand_path('../../../../app/helpers/application_helper', __FILE__)

class ApplicationHelperTest < ActionView::TestCase
  setup do
    create_artist
  end
  
  def test_attachment_progress_container
    html = attachment_progress_container(@artist)
        
    assert_element_in(html, "div#attachmentProgressContainer")
    assert_element_in(html, "span#attachmentButton")
    assert_element_in(html, "input #attachmentmagick_key")
  end
  
  def test_attachment_for_view
    html = attachment_for_view(@artist)
        
    assert_element_in(html, "a.remove_image")
    assert_element_in(html, "input #image_id")
  end
end
