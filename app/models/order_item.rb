class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  has_many :ratings

  validates :price, presence: true, numericality: {
    only_integer: false,
    greater_than_or_equal_to: 0
  }
  validates :quantity, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1
  }

  def subtotal
    quantity * price
  end

  def enabled_rating
    ratings = Rating.where('ratings.order_item_id = ? and ratings.enabled = ?', id, true)
    ratings ? ratings.first : nil
  end

end
