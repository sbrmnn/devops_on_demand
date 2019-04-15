require 'test_helper'

class CloudServicesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cloud_services_index_url
    assert_response :success
  end

end
