class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :title, null: false
      t.decimal :price, null: false
      t.bigint :inventory_count, null: false
      t.text :description
      t.string :item_id, null: false, index: {unique: true}

      t.timestamps
    end
  end
end
