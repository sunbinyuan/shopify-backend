class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.string :cart_id, null: false, index: {unique: true}

      t.timestamps
    end
  end
end
