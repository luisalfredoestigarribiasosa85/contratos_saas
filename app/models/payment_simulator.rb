class PaymentSimulator < ApplicationRecord
  belongs_to :user

  PLANS = %w[pro business].freeze
  STATUSES = %w[pending success failed].freeze

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :plan, presence: true, inclusion: { in: PLANS }
  validates :status, presence: true, inclusion: { in: STATUSES }

  scope :pending, -> { where(status: "pending") }
  scope :successful, -> { where(status: "success") }

  def pending?
    status == "pending"
  end

  def success?
    status == "success"
  end

  def failed?
    status == "failed"
  end

  def plan_label
    case plan
    when "pro" then "Pro"
    when "business" then "Business"
    end
  end
end
