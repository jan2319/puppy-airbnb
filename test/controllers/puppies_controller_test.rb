require 'test_helper'

class PuppiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get puppies_index_url
    assert_response :success
  end

  test "should get show" do
    get puppies_show_url
    assert_response :success
  end

  test "should get new" do
    get puppies_new_url
    assert_response :success
  end

  test "should get create" do
    get puppies_create_url
    assert_response :success
  end

  test "should get edit" do
    get puppies_edit_url
    assert_response :success
  end

  test "should get update" do
    get puppies_update_url
    assert_response :success
  end

  test "should get destroy" do
    get puppies_destroy_url
    assert_response :success
  end

end
