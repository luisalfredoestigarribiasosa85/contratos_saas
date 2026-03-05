class DashboardController < ApplicationController
  def show
    @contracts = current_user.contracts.includes(:contract_template).order(created_at: :desc)
  end
end
