class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :weight
      t.integer :quantity
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
