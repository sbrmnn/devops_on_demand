require 'test_helper'

class Users::FreelancersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_freelancers_index_url
    assert_response :success
  end

  test "should get create" do
    get users_freelancers_create_url
    assert_response :success
  end

  test "should get show" do
    get users_freelancers_show_url
    assert_response :success
  end

  test "should get update" do
    get users_freelancers_update_url
    assert_response :success
  end

  test "should get destroy" do
    get users_freelancers_destroy_url
    assert_response :success
  end

end
