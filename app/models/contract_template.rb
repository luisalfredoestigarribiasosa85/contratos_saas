class ContractTemplate < ApplicationRecord
  has_many :contracts, dependent: :nullify

  validates :name, presence: true
  validates :body, presence: true
  validates :category, presence: true

  def placeholders
    body.scan(/\{\{(\w+)\}\}/).flatten.uniq
  end

  def label_for(placeholder)
    field_config.dig(placeholder, "label") || placeholder.humanize
  end

  def hint_for(placeholder)
    field_config.dig(placeholder, "hint")
  end
end
