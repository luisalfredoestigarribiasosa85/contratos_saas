class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_business_features!
  before_action :set_company
  before_action :authorize_company_access

  def show
    @company_users = @company.company_users.includes(:user)
    @custom_templates = @company.custom_templates.includes(:contract_template)
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to company_path(@company), notice: 'Empresa actualizada exitosamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_company
    @company = current_user.current_company
    redirect_to root_path, alert: 'No tienes una empresa configurada.' unless @company
  end

  def authorize_company_access
    unless current_user.can_use_business_features? && @company.has_user?(current_user)
      redirect_to root_path, alert: 'No tienes permiso para acceder a esta empresa.'
    end
  end

  def require_business_features!
    unless current_user.business?
      redirect_to account_plan_path, alert: 'Esta función requiere un plan Business.'
    end
  end

  def company_params
    params.require(:company).permit(:name, :logo)
  end
end
