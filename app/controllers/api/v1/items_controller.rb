class Api::V1::ItemsController < ApplicationController

  def index
    # render json: Item.all
    render json: ItemSerializer.new(Item.all)
  end

  def show
    # render json: Item.find(params[:id])
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    render json: ItemSerializer.new(Merchant.find(params[:item][:merchant_id]).items.create(item_params)), status: :created
  end

  def update
    if Merchant.exists?(params[:merchant_id]) || params[:merchant_id] == nil
      Item.find(params[:id]).update(item_params)
      render json: ItemSerializer.new(Item.find(params[:id]))
    else
      render status: 400
    end
  end

  def destroy
    render json: Item.delete(params[:id])
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
