require "test_helper"

class ContractGeneratorServiceTest < ActiveSupport::TestCase
  test "replaces placeholders with data" do
    template = contract_templates(:alquiler)
    data = {
      "nombre_locador" => "Juan Pérez",
      "nombre_locatario" => "María López",
      "direccion_inmueble" => "Av. España 123"
    }

    result = ContractGeneratorService.new(template: template, data: data).call

    assert_includes result, "Juan Pérez"
    assert_includes result, "María López"
    assert_includes result, "Av. España 123"
    assert_not_includes result, "{{nombre_locador}}"
    assert_not_includes result, "{{nombre_locatario}}"
  end

  test "leaves unfilled placeholders as empty" do
    template = contract_templates(:pagare)
    data = { "nombre_deudor" => "Carlos" }

    result = ContractGeneratorService.new(template: template, data: data).call

    assert_includes result, "Carlos"
    assert_not_includes result, "{{nombre_deudor}}"
  end

  test "handles symbol keys in data" do
    template = contract_templates(:pagare)
    data = { nombre_deudor: "Carlos", nombre_acreedor: "Ana", monto: "5000000" }

    result = ContractGeneratorService.new(template: template, data: data).call

    assert_includes result, "Carlos"
    assert_includes result, "Ana"
  end
end
