class TicketReply < ApplicationRecord
  belongs_to :support_ticket
  belongs_to :user

  validates :message, presence: true
  validates :support_ticket, presence: true
  validates :user, presence: true
end
