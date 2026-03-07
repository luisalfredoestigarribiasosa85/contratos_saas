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
    @template = ContractTemplate.find(params[:template_id])
    enforce_contract_limit and return
  end

  def create
    @template = ContractTemplate.find(params[:contract_template_id])
    enforce_contract_limit and return
    allowed_keys = @template.placeholders
    data = params.require(:contract_data).permit(*allowed_keys).to_h

    content = ContractGeneratorService.new(template: @template, data: data).call

    @contract = current_user.contracts.build(
      title: "#{@template.name} - #{Date.today.strftime('%d/%m/%Y')}",
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
