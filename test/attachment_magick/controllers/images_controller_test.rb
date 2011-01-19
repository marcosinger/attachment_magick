require File.expand_path('../../../test_helper', __FILE__)

class Publisher::ImagesControllerTest < ActionController::TestCase

  setup do
    create_artist
  end

  test "should create image" do
    post :create, default_hash.merge({ :Filedata => exemple_file }) 
    assert_response :success
    assert_element_in(response.body, :img)
  end

  test "should update priority order" do
    4.times{ @artist.images.create(:photo => exemple_file) }
    @artist.save
    @artist.reload
    
    image_first = @artist.images.first
    image_last  = @artist.images.last

    post :update_sortable, default_hash.merge({ :images => @artist.images.map(&:id).reverse })

    @artist.reload
    
    assert_equal image_first, @artist.images.order_by(:priority.asc).last
    assert_equal image_last,  @artist.images.order_by(:priority.asc).first
  end

  test "should destroy image" do
    get :destroy, default_hash.merge({ :id => @artist.images.first.to_param })

    @artist.reload
    assert_response :success
    assert_nil @artist.images.first
  end


  private 

  def default_hash
    {:klass => @artist.class.name, :klass_id => @artist.id}
  end
end
