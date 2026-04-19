class DashboardController < ApplicationController
  def show
    @contracts = current_user.contracts.includes(:contract_template).order(created_at: :desc)
    
    if current_user.business?
      @company = current_user.current_company
      @custom_templates = @company&.custom_templates&.includes(:contract_template) || []
      @company_users = @company&.company_users&.includes(:user) || []
      @support_tickets = current_user.support_tickets.order(created_at: :desc).limit(5)
    end
  end
end
