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
    assert_includes template.errors[:name], "no puede estar en blanco"
  end

  test "validates presence of body" do
    template = ContractTemplate.new(name: "test", category: "test")
    assert_not template.valid?
    assert_includes template.errors[:body], "no puede estar en blanco"
  end

  test "validates presence of category" do
    template = ContractTemplate.new(name: "test", body: "test")
    assert_not template.valid?
    assert_includes template.errors[:category], "no puede estar en blanco"
  end

  test "label_for returns label from field_config" do
    template = contract_templates(:alquiler)
    assert_equal "Nombre del locador", template.label_for("nombre_locador")
  end

  test "label_for falls back to humanize when no config" do
    template = ContractTemplate.new(
      name: "Test", body: "{{campo_nuevo}}", category: "Test", field_config: {}
    )
    assert_equal "Campo nuevo", template.label_for("campo_nuevo")
  end

  test "hint_for returns hint from field_config" do
    template = contract_templates(:alquiler)
    assert_equal "Nombre completo del inquilino", template.hint_for("nombre_locatario")
  end

  test "hint_for returns nil when no hint configured" do
    template = contract_templates(:alquiler)
    assert_nil template.hint_for("nombre_locador")
  end

  test "hint_for returns nil when placeholder not in field_config" do
    template = ContractTemplate.new(
      name: "Test", body: "{{foo}}", category: "Test", field_config: {}
    )
    assert_nil template.hint_for("foo")
  end
end
