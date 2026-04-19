require "test_helper"

class CustomTemplatesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get custom_templates_index_url
    assert_response :success
  end

  test "should get new" do
    get custom_templates_new_url
    assert_response :success
  end

  test "should get create" do
    get custom_templates_create_url
    assert_response :success
  end

  test "should get edit" do
    get custom_templates_edit_url
    assert_response :success
  end

  test "should get update" do
    get custom_templates_update_url
    assert_response :success
  end

  test "should get destroy" do
    get custom_templates_destroy_url
    assert_response :success
  end
end
