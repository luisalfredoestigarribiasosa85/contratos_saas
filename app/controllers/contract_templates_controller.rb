class ContractTemplatesController < ApplicationController
  def index
    @templates = ContractTemplate.order(:category, :name)
  end

  def show
    @template = ContractTemplate.find(params[:id])
  end
end
