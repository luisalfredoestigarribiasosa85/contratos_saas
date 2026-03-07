require "test_helper"

class ContractTest < ActiveSupport::TestCase
  test "belongs to user" do
    contract = contracts(:one)
    assert_equal users(:one), contract.user
  end

  test "belongs to contract template" do
    contract = contracts(:one)
    assert_equal contract_templates(:alquiler), contract.contract_template
  end

  test "validates presence of title" do
    contract = Contract.new(content: "test", user: users(:one), contract_template: contract_templates(:alquiler))
    assert_not contract.valid?
    assert_includes contract.errors[:title], "no puede estar en blanco"
  end

  test "validates presence of content" do
    contract = Contract.new(title: "test", user: users(:one), contract_template: contract_templates(:alquiler))
    assert_not contract.valid?
    assert_includes contract.errors[:content], "no puede estar en blanco"
  end
end
