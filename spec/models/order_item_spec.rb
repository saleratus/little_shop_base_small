require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'validations' do
    it { should validate_presence_of :price }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of :quantity }
    it { should validate_numericality_of(:quantity).only_integer }
    it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(1) }
  end

  describe 'relationships' do
    it { should belong_to :order }
    it { should belong_to :item }
  end

  describe 'class methods' do
  end

  describe 'instance methods' do
    it '.subtotal' do
      oi = create(:order_item, quantity: 5, price: 3)

      expect(oi.subtotal).to eq(15)
    end

    it '.enabled_rating' do
      oi = create(:order_item)
      rating_1 = create(:rating, order_item: oi, enabled: true)
      expect(oi.enabled_rating).to eq(rating_1)

      rating_1.enabled = false
      rating_1.save
      expect(oi.enabled_rating).to be nil

      rating_2 = create(:rating, order_item: oi, enabled: true)
      expect(oi.enabled_rating).to eq(rating_2)
    end

  end
end
