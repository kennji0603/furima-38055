class ItemsController < ApplicationController
  before_action :authenticate_user!, only: :new
  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to action: :index
    else
      render :new
    end
  end

    def show
      @item = Item.find(params[:id])
    end
  

  private

  def item_params
    params.require(:item).permit(:name, :explanation, :price, :image, :category_id, :condition_id, :postagetype_id,
                                 :prefecture_id, :preparationday_id).merge(user_id: current_user.id)
  end
end
