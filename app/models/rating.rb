class Rating < ApplicationRecord
  belongs_to :order_item

  validates_presence_of :title
  validates_presence_of :description

  validates :score, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5
  }

  def find_order_for
     Order.find(self.order_item.order_id)
  end

end
