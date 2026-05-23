class CompanyInvitation < ApplicationRecord
  belongs_to :company

  before_validation :generate_token, on: :create

  validates :email, presence: true, format: { with: Devise.email_regexp }
  validates :role, presence: true, inclusion: { in: %w[admin member] }
  validates :status, presence: true, inclusion: { in: %w[pending accepted expired declined] }
  validates :token, presence: true, uniqueness: true

  # Ensure a user is not invited multiple times concurrently
  validates :email, uniqueness: { scope: :company_id, message: "ya tiene una invitación pendiente en este equipo.", if: :pending? }

  scope :pending, -> { where(status: "pending") }

  def pending?
    status == "pending"
  end

  def accepted?
    status == "accepted"
  end

  def accept!(user)
    transaction do
      company.add_user(user, role)
      update!(status: "accepted")
    end
  end

  private

  def generate_token
    self.token = SecureRandom.hex(20) if token.blank?
  end
end
