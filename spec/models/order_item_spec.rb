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
    it '#subtotal' do
      oi = create(:order_item, quantity: 5, price: 3)

      expect(oi.subtotal).to eq(15)
    end

    it '#enabled_rating' do
      oi = create(:order_item)
      rating_1 = create(:rating, order_item: oi, enabled: true)
      expect(oi.enabled_rating).to eq(rating_1)

      rating_1.enabled = false
      rating_1.save
      expect(oi.enabled_rating).to be nil

      rating_2 = create(:rating, order_item: oi, enabled: true)
      expect(oi.enabled_rating).to eq(rating_2)
    end

    it '#average_rating_score' do
      yesterday = 1.day.ago
      @user = create(:user)
      @item_1 = create(:item)
      @item_2 = create(:item)
      @order = create(:completed_order, user: @user, created_at: yesterday)
      @oi_1 = create(:fulfilled_order_item, order: @order, item: @item_1, price: 2, quantity: 1, created_at: yesterday, updated_at: 2.hours.ago)
      @oi_2 = create(:fulfilled_order_item, order: @order, item: @item_2, price: 1, quantity: 3, created_at: yesterday, updated_at: yesterday)
      @order_2 = create(:completed_order, user: @user, created_at: 2.days.ago)
      @oi_3 = create(:fulfilled_order_item, order: @order_2, item: @item_1, price: 2, quantity: 5, created_at: 2.days.ago, updated_at: 1.day.ago)

      @user_2 = create(:user)
      @order_other_user = create(:order, user: @user_2, created_at: 2.days.ago)
      @oi_4 = create(:fulfilled_order_item, order: @order_other_user, item: @item_1, price: 2, quantity: 5, created_at: 2.days.ago, updated_at: 1.day.ago)
      #ratings for item 1
      @rating_1 = create(:rating, order_item: @oi_1, score: 1)
      @rating_2 = create(:rating, order_item: @oi_3, score: 4)
      @rating_3 = create(:rating, order_item: @oi_4, score: 5)
      #rating for item 2
      @rating_4 = create(:rating, order_item: @oi_2, score: 3)

      expected_1 = @oi_1.avg_rating_score
      expected_2 = @oi_2.avg_rating_score

      expect(expected_1).to eq("3.33")
      expect(expected_2).to eq("3.0")

      #Sad Path that disabled ratings aren't counted
      @rating_2.update(enabled: false)
      expected_3 = @oi_1.avg_rating_score
      expect(expected_3).to eq("3.0")
    end

  end
end
