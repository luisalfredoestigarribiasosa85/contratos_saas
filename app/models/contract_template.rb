class ContractTemplate < ApplicationRecord
  has_many :contracts, dependent: :nullify

  validates :name, presence: true
  validates :body, presence: true
  validates :category, presence: true

  def placeholders
    body.scan(/\{\{(\w+)\}\}/).flatten.uniq
  end
end
