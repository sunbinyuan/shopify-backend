class CreateSpecificCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :specific_carts do |t|

      t.belongs_to :cart, index: true
      t.belongs_to :item, index: true
      t.bigint :quantity

      t.timestamps
    end
  end
end
