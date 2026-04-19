class SupportTicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_business_features!
  before_action :set_support_ticket, only: [:show]

  def index
    @support_tickets = current_user.support_tickets.order(priority_level: :desc, created_at: :desc)
  end

  def new
    @support_ticket = current_user.support_tickets.build
  end

  def create
    @support_ticket = current_user.support_tickets.build(support_ticket_params)
    
    # Prioridad alta para usuarios Business
    @support_ticket.priority = "high" if current_user.business?
    
    if @support_ticket.save
      redirect_to support_ticket_path(@support_ticket), notice: 'Ticket de soporte creado exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def require_business_features!
    unless current_user.business?
      redirect_to account_plan_path, alert: 'Esta función requiere un plan Business.'
    end
  end

  def set_support_ticket
    @support_ticket = current_user.support_tickets.find(params[:id])
  end

  def support_ticket_params
    params.require(:support_ticket).permit(:subject, :description, :priority)
  end
end
