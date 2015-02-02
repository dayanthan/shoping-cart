class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.integer :mobile
      t.attachment :avatar
      t.string :date_of_birth
      t.integer :user_id

      t.timestamps
    end
  end
end
