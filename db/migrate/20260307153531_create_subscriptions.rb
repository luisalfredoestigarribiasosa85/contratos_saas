class CreateSubscriptions < ActiveRecord::Migration[8.1]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.string :plan, null: false, default: "free"
      t.string :status, null: false, default: "active"
      t.datetime :starts_at, null: false
      t.datetime :expires_at
      t.boolean :lifetime, null: false, default: false

      t.timestamps
    end
  end
end
