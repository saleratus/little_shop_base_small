require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :price }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of :description }
    it { should validate_presence_of :inventory }
    it { should validate_numericality_of(:inventory).only_integer }
    it { should validate_numericality_of(:inventory).is_greater_than_or_equal_to(0) }
  end

  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many :order_items }
    it { should have_many(:orders).through(:order_items) }
  end

  describe 'class methods' do
    describe 'item popularity' do
      before :each do
        merchant = create(:merchant)
        @items = create_list(:item, 6, user: merchant)
        user = create(:user)

        order = create(:completed_order, user: user)
        create(:fulfilled_order_item, order: order, item: @items[3], quantity: 7)
        create(:fulfilled_order_item, order: order, item: @items[1], quantity: 6)
        create(:fulfilled_order_item, order: order, item: @items[0], quantity: 5)
        create(:fulfilled_order_item, order: order, item: @items[2], quantity: 3)
        create(:fulfilled_order_item, order: order, item: @items[5], quantity: 2)
        create(:fulfilled_order_item, order: order, item: @items[4], quantity: 1)
      end
      it '.item_popularity' do
        expect(Item.item_popularity(4, :desc)).to eq([@items[3], @items[1], @items[0], @items[2]])
        expect(Item.item_popularity(4, :asc)).to eq([@items[4], @items[5], @items[2], @items[0]])
      end
      it '.popular_items' do
        expect(Item.popular_items(3)).to eq([@items[3], @items[1], @items[0]])
      end
      it '.unpopular_items' do
        expect(Item.unpopular_items(3)).to eq([@items[4], @items[5], @items[2]])
      end
    end
  end

  describe 'instance methods' do
    it '.avg_fulfillment_time' do
      item = create(:item)
      merchant = item.user
      user = create(:user)
      order = create(:completed_order, user: user)
      create(:fulfilled_order_item, order: order, item: item, created_at: 4.days.ago, updated_at: 1.days.ago)
      create(:fulfilled_order_item, order: order, item: item, created_at: 1.hour.ago, updated_at: 30.minutes.ago)

      expect(item.avg_fulfillment_time).to include("1 day 12:15:00")
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

      expected_1 = @oi_1.item.avg_rating_score
      expected_2 = @oi_2.item.avg_rating_score

      expect(expected_1).to eq("3.33")
      expect(expected_2).to eq("3.0")

      #Sad Path that disabled ratings aren't counted
      @rating_2.update(enabled: false)
      expected_3 = @oi_1.item.avg_rating_score
      expect(expected_3).to eq("3.0")
    end

    it '.ever_ordered?' do
      item_1 = create(:item)
      item_2 = create(:item)
      order = create(:completed_order)
      create(:fulfilled_order_item, order: order, item: item_1, created_at: 4.days.ago, updated_at: 1.days.ago)

      expect(item_1.ever_ordered?).to eq(true)
      expect(item_2.ever_ordered?).to eq(false)
    end
  end
end
