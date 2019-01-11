class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :title
      t.decimal :price
      t.bigint :inventory_count
      t.text :description
      t.string :alias

      t.timestamps
    end
  end
end
