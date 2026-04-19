class CustomTemplate < ApplicationRecord
  belongs_to :company
  belongs_to :contract_template
  
  validates :name, presence: true
  validates :body, presence: true
  validates :description, presence: true
  
  def placeholders
    body.scan(/\{\{(\w+)\}\}/).flatten.uniq
  end
  
  def label_for(placeholder)
    field_config.dig(placeholder, "label") || placeholder.humanize
  end
  
  def hint_for(placeholder)
    field_config.dig(placeholder, "hint")
  end
  
  def clone_from_contract_template
    self.name ||= contract_template.name
    self.description ||= contract_template.description
    self.body ||= contract_template.body
    self.field_config ||= contract_template.field_config
  end
end
