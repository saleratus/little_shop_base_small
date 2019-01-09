class Rating < ApplicationRecord
  belongs_to :order_item

  def find_order_for
     Order.find(self.order_item.order_id)
  end

end
