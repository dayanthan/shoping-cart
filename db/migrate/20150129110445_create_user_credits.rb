class CreateUserCredits < ActiveRecord::Migration
  def change
    create_table :user_credits do |t|
      t.integer :created_user_id
      t.integer :purchased_user_id
      t.integer :item_id
      t.integer :credit_amount
      t.integer :admin_credit_amount

      t.timestamps
    end
  end
end
