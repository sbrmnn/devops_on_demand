require 'test_helper'

class ProfilePreviewControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get profile_preview_index_url
    assert_response :success
  end

end
