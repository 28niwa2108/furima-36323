class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def show
    @sold_out = sold_out_judgment
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    redirect_to root_path if current_user != @item.user || sold_out_judgment
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy if current_user == @item.user
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(
      :item_name,
      :item_info,
      :category_id,
      :status_id,
      :shipping_fee_status_id,
      :prefecture_id,
      :delivery_schedule_id,
      :price,
      :image
    ).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def sold_out_judgment
    order_count = Order.where(item_id: @item.id).length
    if order_count.zero?
      false
    else
      true
    end
  end
end
