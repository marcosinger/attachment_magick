require 'test_helper'
 
class ArtistTest < ActiveSupport::TestCase
  
  setup do
    @rocky_balboa = Artist.new
  end

  def test_access_grid_method
    assert_equal "54x",       @rocky_balboa.grid_1
    assert_equal "150x",      @rocky_balboa.grid_10
    assert_equal "200x300#",  @rocky_balboa.grid_15
    assert_equal "864x230#",  @rocky_balboa.grid_16
  end
end