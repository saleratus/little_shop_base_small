class Profile::RatingsController < ApplicationController

  def new
    @order_item_id = params[:order_item_id]
    @rating = Rating.new
    @form_path = [:profile, @rating]
  end

  def edit
    @rating = Rating.find(params[:id])
    @form_path = [:profile, @rating]
  end

  def create
    rating_params = secure_params
    rating_params[:enabled] = true
    @rating = Rating.create(rating_params)
    if @rating.save
      flash[:success] = "Your rating has been added!"
      order_item = OrderItem.find(rating_params[:order_item_id])
      order = Order.find(order_item.order_id)
      redirect_to profile_order_path(order) and return
    end
    @form_path = [:profile, @rating]
    render :new
  end

  def update
    rating_params = secure_params
    @rating = Rating.find(params[:id])
    rating_params[:enabled] = true
    rating_params[:order_item_id] = @rating.order_item_id
    @rating.update(rating_params)
    if @rating.save
      flash[:success] = "Your changes were recorded!"
      order_item = OrderItem.find(rating_params[:order_item_id])
      order = Order.find(order_item.order_id)
      redirect_to profile_order_path(order) and return
    end
    @form_path = [:profile, @rating]
    render :edit
  end

  private

  def secure_params
    params.require(:rating).permit(:title, :description, :score, :order_item_id)
  end

end
