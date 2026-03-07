require "test_helper"

class SubscriptionTest < ActiveSupport::TestCase
  test "validates plan inclusion" do
    sub = Subscription.new(user: users(:one), plan: "invalid", status: "active", starts_at: Time.current)
    assert_not sub.valid?
    assert sub.errors[:plan].any?
  end

  test "validates status inclusion" do
    sub = Subscription.new(user: users(:one), plan: "free", status: "invalid", starts_at: Time.current)
    assert_not sub.valid?
    assert sub.errors[:status].any?
  end

  test "free? returns true for free plan" do
    sub = subscriptions(:free_subscription)
    assert sub.free?
  end

  test "pro? returns true for active pro plan" do
    sub = subscriptions(:pro_subscription)
    assert sub.pro?
  end

  test "pro? returns false for expired pro plan" do
    sub = subscriptions(:pro_subscription)
    sub.status = "expired"
    assert_not sub.pro?
  end

  test "active? considers lifetime" do
    sub = subscriptions(:pro_subscription)
    sub.expires_at = 1.day.ago
    sub.lifetime = true
    assert sub.active?
  end

  test "plan_label returns localized name" do
    assert_equal "Gratis", subscriptions(:free_subscription).plan_label
    assert_equal "Pro", subscriptions(:pro_subscription).plan_label
  end
end
