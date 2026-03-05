require "test_helper"

class ContractTemplateTest < ActiveSupport::TestCase
  test "extracts placeholders from body" do
    template = contract_templates(:alquiler)
    assert_includes template.placeholders, "nombre_locador"
    assert_includes template.placeholders, "nombre_locatario"
    assert_includes template.placeholders, "direccion_inmueble"
  end

  test "returns unique placeholders" do
    template = ContractTemplate.new(
      name: "Test", body: "{{foo}} and {{foo}} and {{bar}}", category: "Test"
    )
    assert_equal %w[foo bar], template.placeholders
  end

  test "validates presence of name" do
    template = ContractTemplate.new(body: "test", category: "test")
    assert_not template.valid?
    assert_includes template.errors[:name], "can't be blank"
  end

  test "validates presence of body" do
    template = ContractTemplate.new(name: "test", category: "test")
    assert_not template.valid?
    assert_includes template.errors[:body], "can't be blank"
  end

  test "validates presence of category" do
    template = ContractTemplate.new(name: "test", body: "test")
    assert_not template.valid?
    assert_includes template.errors[:category], "can't be blank"
  end
end
