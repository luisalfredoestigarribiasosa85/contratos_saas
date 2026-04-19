class CreateCustomTemplates < ActiveRecord::Migration[8.1]
  def change
    create_table :custom_templates do |t|
      t.references :company, null: false, foreign_key: true
      t.references :contract_template, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.text :body
      t.jsonb :field_config

      t.timestamps
    end
  end
end
