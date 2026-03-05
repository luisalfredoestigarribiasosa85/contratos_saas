require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "redirects to login when not authenticated" do
    get dashboard_path
    assert_redirected_to new_user_session_path
  end

  test "shows dashboard when authenticated" do
    sign_in users(:one)
    get dashboard_path
    assert_response :success
  end
end
