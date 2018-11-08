require 'test_helper'

class SubscriptionSettingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get subscription_settings_index_url
    assert_response :success
  end

end
