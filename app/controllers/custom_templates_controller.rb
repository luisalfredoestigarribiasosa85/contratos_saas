class CustomTemplatesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_business_features!
  before_action :set_company
  before_action :authorize_template_management
  before_action :set_custom_template, only: [:edit, :update, :destroy]

  def index
    @custom_templates = @company.custom_templates.includes(:contract_template)
    @contract_templates = ContractTemplate.all
  end

  def new
    @custom_template = @company.custom_templates.build
    @contract_templates = ContractTemplate.all
    if params[:contract_template_id]
      @custom_template.contract_template_id = params[:contract_template_id]
      @custom_template.clone_from_contract_template
    end
  end

  def create
    @custom_template = @company.custom_templates.build(custom_template_params)
    
    if @custom_template.save
      redirect_to custom_templates_path, notice: 'Plantilla personalizada creada exitosamente.'
    else
      @contract_templates = ContractTemplate.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @contract_templates = ContractTemplate.all
  end

  def update
    if @custom_template.update(custom_template_params)
      redirect_to custom_templates_path, notice: 'Plantilla personalizada actualizada exitosamente.'
    else
      @contract_templates = ContractTemplate.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @custom_template.destroy
    redirect_to custom_templates_path, notice: 'Plantilla personalizada eliminada exitosamente.'
  end

  private

  def set_company
    @company = current_user.current_company
    redirect_to root_path, alert: 'No tienes una empresa configurada.' unless @company
  end

  def authorize_template_management
    unless current_user.can_use_business_features?
      redirect_to account_plan_path, alert: 'Esta función requiere un plan Business.'
    end
  end

  def set_custom_template
    @custom_template = @company.custom_templates.find(params[:id])
  end

  def custom_template_params
    params.require(:custom_template).permit(:name, :description, :body, :contract_template_id, field_config: {})
  end

  def require_business_features!
    unless current_user.business?
      redirect_to account_plan_path, alert: 'Esta función requiere un plan Business.'
    end
  end
end
