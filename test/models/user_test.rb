require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "has many contracts" do
    user = users(:one)
    assert_respond_to user, :contracts
  end

  test "destroying user destroys contracts" do
    user = users(:one)
    assert_difference "Contract.count", -user.contracts.count do
      user.destroy
    end
  end
end
