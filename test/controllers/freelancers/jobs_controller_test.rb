require 'test_helper'

class Freelancers::JobsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get freelancers_jobs_update_url
    assert_response :success
  end

end
