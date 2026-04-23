class ContractsController < ApplicationController
  def index
    @contracts = current_user.contracts.includes(:contract_template).order(created_at: :desc)
  end

  def show
    @contract = current_user.contracts.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        pdf_data = ContractPdfService.new(@contract, user: current_user).call
        send_data pdf_data,
          filename: "#{@contract.title.parameterize}.pdf",
          type: "application/pdf",
          disposition: "inline"
      end
    end
  end

  def new
    if params[:custom_template_id]
      @custom_template = current_user.current_company.custom_templates.find(params[:custom_template_id])
      @template = @custom_template.contract_template
    else
      @template = ContractTemplate.find(params[:template_id])
    end
    enforce_contract_limit and return
  end

  def create
    if params[:custom_template_id]
      @custom_template = current_user.current_company.custom_templates.find(params[:custom_template_id])
      @template = @custom_template.contract_template
      template_content = @custom_template.body
      template_placeholders = @custom_template.placeholders
    else
      @template = ContractTemplate.find(params[:contract_template_id])
      template_content = @template.body
      template_placeholders = @template.placeholders
    end
    
    enforce_contract_limit and return
    allowed_keys = template_placeholders
    data = params.require(:contract_data).permit(*allowed_keys).to_h

    content = ContractGeneratorService.new(template: @template, data: data).call

    @contract = current_user.contracts.build(
      title: "#{@custom_template&.name || @template.name} - #{Date.today.strftime('%d/%m/%Y')}",
      content: content,
      contract_template: @template,
      data: data
    )

    if @contract.save
      redirect_to @contract, notice: "Contrato generado exitosamente."
    else
      @template = @template
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @contract = current_user.contracts.find(params[:id])
    @contract.destroy
    redirect_to contracts_path, notice: "Contrato eliminado."
  end

  private

  def enforce_contract_limit
    unless current_user.can_create_contract?
      redirect_to account_plan_path, alert: "Alcanzaste el límite de #{current_user.monthly_contract_limit} contratos este mes. Mejorá tu plan para contratos ilimitados."
    end
  end
end
