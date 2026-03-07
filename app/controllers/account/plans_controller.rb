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
  end
end
