class CreateContracts < ActiveRecord::Migration[8.1]
  def change
    create_table :contracts do |t|
      t.string :title
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :contract_template, null: false, foreign_key: true
      t.jsonb :data

      t.timestamps
    end
  end
end
