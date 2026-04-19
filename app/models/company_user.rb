class CompanyUser < ApplicationRecord
  belongs_to :company
  belongs_to :user
  
  validates :role, presence: true, inclusion: { in: %w[owner admin member] }
  validates :user_id, uniqueness: { scope: :company_id }
  
  ROLES = %w[owner admin member].freeze
  
  def owner?
    role == "owner"
  end
  
  def admin?
    role == "admin"
  end
  
  def member?
    role == "member"
  end
  
  def can_manage_users?
    owner? || admin?
  end
  
  def can_manage_templates?
    owner? || admin?
  end
end
