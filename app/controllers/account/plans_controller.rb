module Account
  class PlansController < ApplicationController
    def show
      @subscription = current_user.subscription
    end

    def checkout
      @plan = params[:plan]
      @lifetime = params[:lifetime] == "true"

      unless %w[pro business].include?(@plan)
        redirect_to account_plan_path, alert: "Plan no válido."
      end
    end

    def downgrade
      plan = params[:plan]
      unless Subscription::PLANS.include?(plan)
        redirect_to account_plan_path, alert: "Plan no válido."
        return
      end
      
      current_user.subscription.update!(plan: plan)
      redirect_to account_plan_path, notice: "Tu plan ha sido cambiado exitosamente a #{current_user.subscription.plan_label}."
    end
  end
end
