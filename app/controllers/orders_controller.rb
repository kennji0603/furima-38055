class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :move_to_items_index, only: [:index, :create]
  def index
    @item = Item.find(params[:item_id])
    @order_shipping_address = OrderShippingAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    binding.pry
    @order_shipping_address = OrderShippingAddress.new(order_params)
    if @order_shipping_address.valid?
      @order_shipping_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_shipping_address).permit(:postal_code, :city, :house_number, :building_name, :phone_number, :prefecture_id).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def move_to_items_index
    @item = Item.find(params[:item_id])
   if @item.user_id == current_user.id
    redirect_to root_path
   end
  end
end