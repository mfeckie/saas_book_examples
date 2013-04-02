# This migration comes from subscribem (originally 20121117221450)
class AddSubscribemAccountsUsersTable < ActiveRecord::Migration
  def change
    create_table :subscribem_accounts_users, :id => false do |t|
      t.integer :account_id
      t.integer :user_id
    end

    add_index :subscribem_accounts_users, :account_id
  end
end
