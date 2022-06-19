class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :move_to_items_index, only: [:index, :create]
  def index
    @item = Item.find(params[:item_id])
    @order_shipping_address = OrderShippingAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_shipping_address = OrderShippingAddress.new(order_params)
    if @order_shipping_address.valid?
      pay_item
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
   unless  @item.order.blank? && @item.user_id != current_user.id
    redirect_to root_path
   end
  end

  def pay_item
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: order_params[:token],
        currency: 'jpy'
      )
  end   
end