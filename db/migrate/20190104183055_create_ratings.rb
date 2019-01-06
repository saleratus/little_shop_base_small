class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.string :title
      t.text :description
      t.integer :score
      t.references :order_item, foreign_key: true

      t.timestamps
    end
  end
end
