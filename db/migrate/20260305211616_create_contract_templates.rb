class CreateContractTemplates < ActiveRecord::Migration[8.1]
  def change
    create_table :contract_templates do |t|
      t.string :name
      t.text :description
      t.text :body
      t.string :category

      t.timestamps
    end
  end
end
