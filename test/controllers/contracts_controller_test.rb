require "test_helper"

class ContractsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @template = contract_templates(:alquiler)
    @contract = contracts(:one)
    sign_in @user
  end

  test "index lists user contracts" do
    get contracts_path
    assert_response :success
  end

  test "show displays contract" do
    get contract_path(@contract)
    assert_response :success
  end

  test "new shows form for template" do
    get new_contract_path(template_id: @template.id)
    assert_response :success
  end

  test "create generates contract" do
    assert_difference "Contract.count", 1 do
      post contracts_path, params: {
        contract_template_id: @template.id,
        contract_data: {
          nombre_locador: "Juan",
          nombre_locatario: "María",
          direccion_inmueble: "Av. España 123"
        }
      }
    end
    assert_redirected_to contract_path(Contract.last)
  end

  test "destroy deletes contract" do
    assert_difference "Contract.count", -1 do
      delete contract_path(@contract)
    end
    assert_redirected_to contracts_path
  end

  test "cannot access other user contracts" do
    other_user = users(:two)
    other_contract = Contract.create!(
      title: "Other", content: "Content", user: other_user,
      contract_template: @template, data: {}
    )
    get contract_path(other_contract)
    assert_response :not_found
  end
end
