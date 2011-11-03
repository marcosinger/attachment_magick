require 'test_helper'

class AttachmentMagick::ImagesControllerTest < ActionController::TestCase

  setup do
    create_artist
    create_work(@artist)
    create_place
  end

  test "should create artist image" do
    post :create, artist_hash.merge({ :Filedata => example_file })
    assert_response :success
    assert  assert_element_in(response.body, "img")
    assert  assert_element_in(response.body, "div[@class='grid_5 attachment_magick_image']")
  end

  test "should create artist vimeo video" do
    post :create, artist_hash.merge({ :source => example_vimeo })
    assert_response :success
    assert  assert_element_in(response.body, "img")
  end

  test "should create artist youtube video" do
    post :create, artist_hash.merge({ :source => example_youtube })
    assert_response :success
    assert  assert_element_in(response.body, "img")
  end

  test "should create work image" do
    post :create, work_hash.merge({ :Filedata => example_file })
    assert_response :success
    assert  assert_element_in(response.body, "img")
    assert  assert_element_in(response.body, "div[@class='image_caption']")
    assert  assert_element_in(response.body, "div[@class='image_thumb']")
  end

  test "should create place image" do
    post :create, place_hash.merge({ :Filedata => example_file })
    assert_response :success
    assert  assert_element_in(response.body, "img")
  end

  test "should update priority order" do
    4.times{ @artist.images.create(:photo => example_file) }
    @artist.save
    @artist.reload

    image_first = @artist.images.first
    image_last  = @artist.images.last

    post :update_sortable, artist_hash.merge({ :images => @artist.images.map(&:id).reverse })

    @artist.reload

    assert_equal image_first, @artist.images.order_by(:priority.asc).last
    assert_equal image_last,  @artist.images.order_by(:priority.asc).first
  end

  test "should destroy image" do
    get :destroy, artist_hash.merge({ :id => @artist.images.first.to_param })

    @artist.reload
    assert_response :success
    assert_nil @artist.images.first
  end


  private

  def artist_hash
    {:data_attachment => "#{@artist.class.name}_#{@artist.id}"}
  end

  def work_hash
    {:data_attachment => "#{@artist.class.name}_#{@artist.id}_works_#{@artist.works.last.id}", :data_partial => example_partial}
  end

  def place_hash
    {:data_attachment => "#{@place.class.name}_#{@place.id}"}
  end
end
