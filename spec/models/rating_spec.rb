require 'rails_helper'

RSpec.describe Rating, type: :model do
  
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :score }

    it { should validate_numericality_of(:score).only_integer }
    it { should validate_numericality_of(:score).is_greater_than_or_equal_to(1) }
    it { should validate_numericality_of(:score).is_less_than_or_equal_to(5) }
  end

  describe 'relationships' do
    it { should belong_to :order_item }
  end

  describe 'instance methods' do
    it '.find_order_for' do
      order = create(:order)
      oi = create(:order_item, order: order)
      rating = create(:rating, order_item: oi)

      expect(rating.find_order_for).to eq(order)
    end
  end

end
