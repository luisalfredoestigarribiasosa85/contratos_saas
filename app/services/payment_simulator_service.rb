# PaymentSimulatorService
#
# Simulates payment processing for local development.
# Designed to be replaced by BancardPaymentService when real
# payment gateway integration is ready.
#
# Usage:
#   service = PaymentSimulatorService.new(user: current_user, plan: "pro", amount: 39000)
#   payment = service.create_payment
#   service.mark_success(payment)  # or service.mark_failed(payment)
#
class PaymentSimulatorService
  PLAN_PRICES = {
    "pro" => 39_000,
    "business" => 120_000
  }.freeze

  def initialize(user:, plan:, amount: nil)
    @user = user
    @plan = plan
    @amount = amount || PLAN_PRICES.fetch(plan)
  end

  def create_payment
    payment = @user.payment_simulators.create!(
      plan: @plan,
      amount: @amount,
      status: "pending"
    )

    Rails.logger.info "[PaymentSimulator] Pago creado ##{payment.id} — Plan: #{@plan}, Monto: Gs. #{@amount}, Usuario: #{@user.email}"
    payment
  end

  def mark_success(payment)
    payment.update!(status: "success")
    upgrade_subscription!

    Rails.logger.info "[PaymentSimulator] Pago ##{payment.id} EXITOSO — Usuario #{@user.email} actualizado a plan #{@plan}"
    payment
  end

  def mark_failed(payment)
    payment.update!(status: "failed")

    Rails.logger.info "[PaymentSimulator] Pago ##{payment.id} FALLIDO — Usuario #{@user.email} permanece en plan #{@user.plan_name}"
    payment
  end

  private

  def upgrade_subscription!
    subscription = @user.subscription || @user.build_subscription

    subscription.update!(
      plan: @plan,
      status: "active",
      starts_at: Time.current,
      expires_at: 1.month.from_now
    )
  end
end
