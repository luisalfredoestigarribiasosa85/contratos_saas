class CreatePaymentSimulators < ActiveRecord::Migration[8.1]
  def change
    create_table :payment_simulators do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :amount, null: false
      t.string :plan, null: false
      t.string :status, null: false, default: "pending"

      t.timestamps
    end
  end
end
