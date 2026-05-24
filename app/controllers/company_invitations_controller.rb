class CompanyInvitationsController < ApplicationController
  before_action :authenticate_user!, except: [:accept_via_token, :decline_via_token]
  before_action :set_invitation, only: [:accept, :decline]
  before_action :set_invitation_by_token, only: [:accept_via_token, :decline_via_token]

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

  def accept_via_token
    if user_signed_in?
      if current_user.email == @invitation.email
        if @invitation.accept!(current_user)
          redirect_to dashboard_path, notice: "Te has unido al equipo de #{@invitation.company.name}."
        else
          redirect_to dashboard_path, alert: "No se pudo aceptar la invitación."
        end
      else
        redirect_to root_path, alert: "Esta invitación fue enviada a otro email. Inicia sesión con la cuenta correcta."
      end
    else
      store_location_for(:user, accept_via_token_company_invitation_path(token: params[:token]))
      redirect_to new_user_session_path, notice: "Inicia sesión o regístrate para aceptar la invitación."
    end
  end

  def decline_via_token
    @invitation.update!(status: 'declined')
    if user_signed_in?
      redirect_to dashboard_path, notice: "Invitación rechazada."
    else
      redirect_to root_path, notice: "Invitación rechazada."
    end
  end

  private

  def set_invitation
    @invitation = CompanyInvitation.pending.find_by!(id: params[:id], email: current_user.email)
  rescue ActiveRecord::RecordNotFound
    redirect_to dashboard_path, alert: "No se encontró la invitación o no pertenece a tu usuario."
  end

  def set_invitation_by_token
    @invitation = CompanyInvitation.pending.find_by!(token: params[:token])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "El enlace de invitación no es válido o ya fue procesado."
  end
end
