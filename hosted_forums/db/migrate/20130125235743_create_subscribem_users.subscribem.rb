# This migration comes from subscribem (originally 20121115224233)
class CreateSubscribemUsers < ActiveRecord::Migration
  def change
    create_table :subscribem_users do |t|
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
