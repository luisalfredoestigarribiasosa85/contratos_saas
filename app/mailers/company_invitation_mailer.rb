class CompanyInvitationMailer < ApplicationMailer
  def invite
    @invitation = params[:invitation]
    @company = @invitation.company
    @inviter = @company.owner
    @role_label = @invitation.role == "admin" ? "Administrador" : "Miembro"

    mail(
      to: @invitation.email,
      subject: "#{@company.name} te ha invitado a unirte a su equipo en ContratoFácil"
    )
  end
end