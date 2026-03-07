class AddFieldConfigToContractTemplates < ActiveRecord::Migration[8.1]
  def change
    add_column :contract_templates, :field_config, :jsonb, default: {}
  end
end
