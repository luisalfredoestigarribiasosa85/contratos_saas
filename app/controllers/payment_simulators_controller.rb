class PaymentSimulatorsController < ApplicationController
  def new
    @plan = params[:plan]
    @plan = "pro" unless %w[pro business].include?(@plan)
    @amount = PaymentSimulatorService::PLAN_PRICES[@plan]
  end

  def create
    plan = params[:plan]
    unless %w[pro business].include?(plan)
      redirect_to new_payment_simulator_path, alert: "Plan no válido."
      return
    end

    service = PaymentSimulatorService.new(user: current_user, plan: plan)
    payment = service.create_payment

    redirect_to payment_simulator_path(payment)
  end

  def show
    @payment = current_user.payment_simulators.find(params[:id])
  end

  def success
    @payment = current_user.payment_simulators.find(params[:payment_id])

    if @payment.pending?
      service = PaymentSimulatorService.new(user: current_user, plan: @payment.plan)
      service.mark_success(@payment)
    end

    @subscription = current_user.subscription.reload
  end

  def fail
    @payment = current_user.payment_simulators.find(params[:payment_id])

    if @payment.pending?
      service = PaymentSimulatorService.new(user: current_user, plan: @payment.plan)
      service.mark_failed(@payment)
    end
  end
end
