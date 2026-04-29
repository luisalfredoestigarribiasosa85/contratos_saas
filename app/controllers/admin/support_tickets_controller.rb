class Admin::SupportTicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!
  before_action :set_support_ticket, only: [:show, :update]

  def index
    @support_tickets = SupportTicket.includes(:user, :ticket_replies)
                                .order(created_at: :desc)
                                .sort_by { |t| -t.priority_level }
  end

  def show
    @ticket_reply = @support_ticket.ticket_replies.build
  end

  def update
    if @support_ticket.update(support_ticket_params)
      redirect_to admin_support_ticket_path(@support_ticket), notice: 'Ticket actualizado exitosamente.'
    else
      render :show, status: :unprocessable_entity
    end
  end

  def create_reply
    @support_ticket = SupportTicket.find(params[:id])
    @ticket_reply = @support_ticket.ticket_replies.build(reply_params)
    @ticket_reply.user = current_user

    if @ticket_reply.save
      # Actualizar estado del ticket si está en "open"
      @support_ticket.update(status: 'in_progress') if @support_ticket.open?
      redirect_to admin_support_ticket_path(@support_ticket), notice: 'Respuesta enviada exitosamente.'
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def set_support_ticket
    @support_ticket = SupportTicket.find(params[:id])
  end

  def support_ticket_params
    params.require(:support_ticket).permit(:status, :priority)
  end

  def reply_params
    params.require(:ticket_reply).permit(:message)
  end

  def require_admin!
    unless current_user.admin?
      redirect_to root_path, alert: 'Acceso no autorizado.'
    end
  end
end
