require 'rails_helper'

RSpec.describe Rating, type: :model do

  describe 'instance methods' do
    it '.find_order_for' do
      order = create(:order)
      oi = create(:order_item, order: order)
      rating = create(:rating, order_item: oi)

      expect(rating.find_order_for).to eq(order)
    end
  end

end
