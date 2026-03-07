require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "home page is accessible without login" do
    get root_path
    assert_response :success
    assert_select "h1", /Generá contratos legales en segundos/
  end

  test "pricing page is accessible without login" do
    get pricing_path
    assert_response :success
    assert_select "h1", /Planes y precios/
  end

  test "home page shows CTA buttons" do
    get root_path
    assert_select "a", text: "Probar Gratis"
    assert_select "a", text: "Ver Precios"
  end
end
