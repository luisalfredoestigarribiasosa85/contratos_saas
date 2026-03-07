class Subscription < ApplicationRecord
  belongs_to :user

  PLANS = %w[free pro business].freeze

  validates :plan, presence: true, inclusion: { in: PLANS }
  validates :status, presence: true, inclusion: { in: %w[active expired cancelled] }
  validates :starts_at, presence: true
  validates :user_id, uniqueness: true

  scope :active, -> { where(status: "active") }

  def active?
    status == "active" && (expires_at.nil? || expires_at > Time.current || lifetime?)
  end

  def free?
    plan == "free"
  end

  def pro?
    plan == "pro" && active?
  end

  def business?
    plan == "business" && active?
  end

  def plan_label
    case plan
    when "free" then "Gratis"
    when "pro" then "Pro"
    when "business" then "Business"
    end
  end
end
