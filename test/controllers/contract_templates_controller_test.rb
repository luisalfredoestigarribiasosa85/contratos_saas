require "test_helper"

class ContractTemplatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)
  end

  test "index lists templates" do
    get contract_templates_path
    assert_response :success
  end

  test "show displays template" do
    get contract_template_path(contract_templates(:alquiler))
    assert_response :success
  end
end
