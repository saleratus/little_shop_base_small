class MerchantsController < ApplicationController
  before_action :require_merchant, only: :show

  def index
    flags = {role: :merchant}
    unless current_admin?
      flags[:active] = true
    end
    @merchants = User.where(flags)

    this_month = DateTime.current.month
    this_year = DateTime.current.year
    last_month = 1.month.ago.month
    last_month_year = 1.month.ago.year

    @top_3_revenue_merchants = User.top_3_revenue_merchants
    @top_3_fulfilling_merchants = User.top_3_fulfilling_merchants
    @bottom_3_fulfilling_merchants = User.bottom_3_fulfilling_merchants

    @top_10_quantity_merchants_this_month = User.top_item_merchants_by_monthyear(3, @this_month, @this_year)
    @top_10_quantity_merchants_last_month = User.top_item_merchants_by_monthyear(3, @last_month, @last_month_year)
    @top_10_order_merchants_this_month = User.top_order_merchants_by_monthyear(3, @this_month, @this_year)
    @top_10_order_merchants_last_month = User.top_order_merchants_by_monthyear(3, @last_month, @last_month_year)

    @top_3_states = Order.top_3_states
    @top_3_cities = Order.top_3_cities
    @top_3_quantity_orders = Order.top_3_quantity_orders
  end

  def show
    @merchant = current_user
    @orders = @merchant.my_pending_orders
    @top_5_items = @merchant.top_items_by_quantity(5)
    @qsp = @merchant.quantity_sold_percentage
    @top_3_states = @merchant.top_3_states
    @top_3_cities = @merchant.top_3_cities
    @most_ordering_user = @merchant.most_ordering_user
    @most_items_user = @merchant.most_items_user
    @most_items_user = @merchant.most_items_user
    @top_3_revenue_users = @merchant.top_3_revenue_users
  end

  private

  def require_merchant
    render file: 'errors/not_found', status: 404 unless current_user && current_merchant?
  end
end
