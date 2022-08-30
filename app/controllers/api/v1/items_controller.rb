class Api::V1::ItemsController < ApplicationController

  def index
    # render json: Item.all
    render json: ItemSerializer.new(Item.all)
  end

  def show
    # render json: Item.find(params[:id])
    render json: ItemSerializer.new(Item.find(params[:id]))
  end
end
