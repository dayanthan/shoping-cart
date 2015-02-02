class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :item_id
      t.integer :created_user_id
      t.integer :purchased_user_id
      t.string :ip_address
      t.string :first_name
      t.string :last_name
      t.string :card_type
      t.date :card_expires_on
      t.string :card_number
      t.string :card_verification
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :zipcode
      t.string :phone
      t.timestamps
    end
  end
end

