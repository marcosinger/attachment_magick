require 'test_helper'

class ArtistsControllerTest < ActionController::TestCase
  
  setup do
    Artist.create(:name => "Johnny", :lastname => "Depp")
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:artists)
  end
end
