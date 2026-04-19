class CreateSupportTickets < ActiveRecord::Migration[8.1]
  def change
    create_table :support_tickets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :subject, null: false
      t.text :description, null: false
      t.string :status, null: false, default: "open"
      t.string :priority, null: false, default: "normal"

      t.timestamps
    end
  end
end
