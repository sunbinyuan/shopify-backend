class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.string :cart_id


      t.timestamps
    end
  end
end
