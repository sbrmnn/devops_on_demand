require 'test_helper'

class ChatroomsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get chatrooms_create_url
    assert_response :success
  end

end
