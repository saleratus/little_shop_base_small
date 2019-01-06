class AddRatingToOrderItem < ActiveRecord::Migration[5.1]
  def change
    add_reference :order_items, :rating, foreign_key: true
  end
end
