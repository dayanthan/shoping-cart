class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :user_id
      t.string :user_name
      t.string :user_email
      t.string :password
      t.boolean :user_type

      t.timestamps
    end
  end
end
