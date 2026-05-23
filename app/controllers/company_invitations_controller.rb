class CompanyInvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_invitation

  def accept
    if @invitation.accept!(current_user)
      redirect_to dashboard_path, notice: "Te has unido al equipo de #{@invitation.company.name}."
    else
      redirect_to dashboard_path, alert: "No se pudo aceptar la invitación."
    end
  end

  def decline
    @invitation.update!(status: 'declined')
    redirect_to dashboard_path, notice: "Invitación rechazada."
  end

  private

  def set_invitation
    @invitation = CompanyInvitation.pending.find_by!(id: params[:id], email: current_user.email)
  rescue ActiveRecord::RecordNotFound
    redirect_to dashboard_path, alert: "No se encontró la invitación o no pertenece a tu usuario."
  end
end
