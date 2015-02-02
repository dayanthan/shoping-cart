class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :discription
      t.integer :price
      t.integer :discount
      t.integer :category_id
      t.integer :user_id
      t.integer :available
      t.attachment :item_image

      t.timestamps
    end
  end
end
