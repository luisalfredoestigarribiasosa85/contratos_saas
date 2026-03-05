class Contract < ApplicationRecord
  belongs_to :user
  belongs_to :contract_template

  validates :title, presence: true
  validates :content, presence: true
end
