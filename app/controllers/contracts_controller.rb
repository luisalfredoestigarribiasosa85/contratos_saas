class ContractsController < ApplicationController
  def index
    @contracts = current_user.contracts.includes(:contract_template).order(created_at: :desc)
  end

  def show
    @contract = current_user.contracts.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        pdf_data = ContractPdfService.new(@contract).call
        send_data pdf_data,
          filename: "#{@contract.title.parameterize}.pdf",
          type: "application/pdf",
          disposition: "inline"
      end
    end
  end

  def new
    @template = ContractTemplate.find(params[:template_id])
  end

  def create
    @template = ContractTemplate.find(params[:contract_template_id])
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
end
