class CreateCompanyInvitations < ActiveRecord::Migration[8.1]
  def change
    create_table :company_invitations do |t|
      t.references :company, null: false, foreign_key: true
      t.string :email, null: false
      t.string :role, null: false, default: 'member'
      t.string :token, null: false
      t.string :status, null: false, default: 'pending'

      t.timestamps
    end

    add_index :company_invitations, :token, unique: true
    add_index :company_invitations, [:company_id, :email], unique: true, where: "status = 'pending'"
  end
end
