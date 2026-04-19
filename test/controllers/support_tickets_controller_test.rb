require "test_helper"

class SupportTicketsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get support_tickets_index_url
    assert_response :success
  end

  test "should get new" do
    get support_tickets_new_url
    assert_response :success
  end

  test "should get create" do
    get support_tickets_create_url
    assert_response :success
  end

  test "should get show" do
    get support_tickets_show_url
    assert_response :success
  end
end
