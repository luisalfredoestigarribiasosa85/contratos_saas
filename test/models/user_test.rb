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

  test "creates free subscription on create" do
    user = User.create!(email: "nuevo@example.com", password: "password123")
    assert_not_nil user.subscription
    assert_equal "free", user.subscription.plan
    assert_equal "active", user.subscription.status
  end

  test "free? returns true for free plan user" do
    assert users(:one).free?
  end

  test "pro? returns true for pro plan user" do
    assert users(:two).pro?
  end

  test "can_create_contract? respects monthly limit" do
    user = users(:one)
    assert user.can_create_contract?
  end

  test "contracts_remaining returns count for free users" do
    user = users(:one)
    remaining = user.contracts_remaining
    assert_kind_of Integer, remaining
    assert remaining >= 0
  end

  test "contracts_remaining returns nil for pro users" do
    user = users(:two)
    assert_nil user.contracts_remaining
  end
end
