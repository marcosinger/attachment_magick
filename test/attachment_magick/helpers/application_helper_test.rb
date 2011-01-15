require File.join(File.dirname(__FILE__), '..', '..', 'test_helper')

class ApplicationHelperTest < ActionView::TestCase
  setup do
    create_artist
  end
  
  def test_attachment_for
    html = attachment_for(@artist)
        
    assert_element_in(html, "div.thumbnails")
    assert_element_in(html, "div.thumbnails div#attachmentProgressContainer")
    assert_element_in(html, "div.thumbnails span#attachmentButton")
    assert_element_in(html, "div.thumbnails div#attachmentSortable")
    assert_element_in(html, :img)
    assert_element_in(html, "div.thumbnails input #klass")
    assert_element_in(html, "div.thumbnails input #klass_id")
  end
end
