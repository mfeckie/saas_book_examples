# This migration comes from subscribem (originally 20130320070606)
class CreateSubscribemPlans < ActiveRecord::Migration
  def change
    create_table :subscribem_plans do |t|
      t.string :name
      t.string :description
      t.float :price
      t.string :braintree_id

      t.timestamps
    end
  end
end
