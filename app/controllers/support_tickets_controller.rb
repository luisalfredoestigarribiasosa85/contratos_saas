class SupportTicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_support_ticket, only: [:show, :create_reply]

  def index
    @support_tickets = current_user.support_tickets.order(created_at: :desc).sort_by { |t| -t.priority_level }
  end

  def new
    @support_ticket = current_user.support_tickets.build
    # Set default priority based on user plan
    @support_ticket.priority = current_user.business? ? "high" : "normal"
  end

  def create
    @support_ticket = current_user.support_tickets.build(support_ticket_params)
    
    # Prioridad alta para usuarios Business (sobrescribe si el usuario intenta cambiarla)
    @support_ticket.priority = "high" if current_user.business?
    
    if @support_ticket.save
      redirect_to support_ticket_path(@support_ticket), notice: 'Ticket de soporte creado exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @ticket_reply = @support_ticket.ticket_replies.build
  end

  def create_reply
    @ticket_reply = @support_ticket.ticket_replies.build(reply_params)
    @ticket_reply.user = current_user

    if @ticket_reply.save
      redirect_to support_ticket_path(@support_ticket), notice: 'Respuesta enviada exitosamente.'
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def set_support_ticket
    @support_ticket = current_user.support_tickets.find(params[:id])
  end

  def support_ticket_params
    params.require(:support_ticket).permit(:subject, :description, :priority)
  end

  def reply_params
    params.require(:ticket_reply).permit(:message)
  end
end
