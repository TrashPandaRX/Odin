require "test_helper"

class KittenControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get kitten_index_url
    assert_response :success
  end

  test "should get show" do
    get kitten_show_url
    assert_response :success
  end

  test "should get new" do
    get kitten_new_url
    assert_response :success
  end

  test "should get create" do
    get kitten_create_url
    assert_response :success
  end

  test "should get edit" do
    get kitten_edit_url
    assert_response :success
  end

  test "should get update" do
    get kitten_update_url
    assert_response :success
  end

  test "should get destroy" do
    get kitten_destroy_url
    assert_response :success
  end
end
