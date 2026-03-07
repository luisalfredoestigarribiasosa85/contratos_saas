class CreateDefaultSubscriptionsForExistingUsers < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      INSERT INTO subscriptions (user_id, plan, status, starts_at, lifetime, created_at, updated_at)
      SELECT id, 'free', 'active', NOW(), false, NOW(), NOW()
      FROM users
      WHERE id NOT IN (SELECT user_id FROM subscriptions)
    SQL
  end

  def down
    execute "DELETE FROM subscriptions WHERE plan = 'free'"
  end
end
