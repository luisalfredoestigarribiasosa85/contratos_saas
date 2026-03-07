require "test_helper"

module Account
  class PlansControllerTest < ActionDispatch::IntegrationTest
    test "redirects to login when not authenticated" do
      get account_plan_path
      assert_redirected_to new_user_session_path
    end

    test "shows plan page when authenticated" do
      sign_in users(:one)
      get account_plan_path
      assert_response :success
    end

    test "shows checkout page for pro plan" do
      sign_in users(:one)
      get checkout_account_plan_path(plan: "pro")
      assert_response :success
    end

    test "redirects checkout for invalid plan" do
      sign_in users(:one)
      get checkout_account_plan_path(plan: "invalid")
      assert_redirected_to account_plan_path
    end
  end
end
