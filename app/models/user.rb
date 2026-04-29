class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :contracts, dependent: :destroy
  has_many :payment_simulators, dependent: :destroy
  has_one :subscription, dependent: :destroy
  has_one :company, dependent: :destroy
  has_many :company_users, dependent: :destroy
  has_many :companies, through: :company_users
  has_many :support_tickets, dependent: :destroy

  after_create :create_free_subscription

  def free?
    subscription.nil? || subscription.free?
  end

  def pro?
    subscription&.pro? || false
  end

  def business?
    subscription&.business? || false
  end

  def plan_name
    subscription&.plan || "free"
  end

  def contracts_this_month
    contracts.where(created_at: Time.current.beginning_of_month..)
  end

  def monthly_contract_limit
    free? ? 3 : nil
  end

  def contracts_remaining
    return nil unless free?
    [ monthly_contract_limit - contracts_this_month.count, 0 ].max
  end

  def can_create_contract?
    !free? || contracts_this_month.count < monthly_contract_limit
  end

  def company_owner?
    company.present?
  end

  def company_admin?
    company_users.exists?(role: "admin")
  end

  def company_member?
    company_users.exists?
  end

  def current_company
    company || companies.first
  end

  def can_use_business_features?
    business? && (company_owner? || company_admin?)
  end

  def admin?
    email == 'admin@contratossaas.com' || email == 'luisalfredoestigarribiasosa85@gmail.com'
  end

  private

  def create_free_subscription
    create_subscription!(
      plan: "free",
      status: "active",
      starts_at: Time.current
    )
  end
end
