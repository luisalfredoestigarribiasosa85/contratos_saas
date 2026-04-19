class SupportTicket < ApplicationRecord
  belongs_to :user
  
  validates :subject, presence: true, length: { maximum: 255 }
  validates :description, presence: true
  validates :status, presence: true, inclusion: { in: %w[open in_progress resolved closed] }
  validates :priority, presence: true, inclusion: { in: %w[low normal high urgent] }
  
  STATUSES = %w[open in_progress resolved closed].freeze
  PRIORITIES = %w[low normal high urgent].freeze
  
  def open?
    status == "open"
  end
  
  def in_progress?
    status == "in_progress"
  end
  
  def resolved?
    status == "resolved"
  end
  
  def closed?
    status == "closed"
  end
  
  def priority_level
    case priority
    when "urgent" then 4
    when "high" then 3
    when "normal" then 2
    when "low" then 1
    else 0
    end
  end
  
  def self.for_business_users
    joins(user: :subscription).where(subscriptions: { plan: "business", status: "active" })
  end
end
