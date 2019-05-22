require 'test_helper'

class FeaturedEngineersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get featured_engineers_index_url
    assert_response :success
  end

end
