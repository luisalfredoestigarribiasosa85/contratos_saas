class Companies::CompanyInvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_business_features!
  before_action :set_company
  before_action :authorize_company_management!

  def create
    @invitation = @company.company_invitations.build(invitation_params)
    @invitation.status = 'pending'

    if @invitation.save
      CompanyInvitationMailer.with(invitation: @invitation).invite.deliver_later
      redirect_to company_path(@company), notice: "Invitación enviada a #{@invitation.email}."
    else
      redirect_to company_path(@company), alert: @invitation.errors.full_messages.to_sentence
    end
  end

  def destroy
    @invitation = @company.company_invitations.find(params[:id])
    email = @invitation.email
    @invitation.destroy
    redirect_to company_path(@company), notice: "Invitación para #{email} cancelada."
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def authorize_company_management!
    company_user = @company.company_users.find_by(user: current_user)
    unless company_user&.can_manage_users?
      redirect_to root_path, alert: 'No tienes permiso para gestionar este equipo.'
    end
  end

  def require_business_features!
    unless current_user.can_use_business_features?
      redirect_to account_plan_path, alert: 'Esta función requiere un plan Business.'
    end
  end

  def invitation_params
    params.require(:company_invitation).permit(:email, :role)
  end
end
