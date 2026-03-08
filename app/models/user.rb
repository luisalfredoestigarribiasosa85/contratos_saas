class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :contracts, dependent: :destroy
  has_many :payment_simulators, dependent: :destroy
  has_one :subscription, dependent: :destroy

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

  private

  def create_free_subscription
    create_subscription!(
      plan: "free",
      status: "active",
      starts_at: Time.current
    )
  end
end
