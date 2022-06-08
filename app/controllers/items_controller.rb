class ItemsController < ApplicationController

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else 
    items = Item.all
    end
    render json: items, include: :user
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: 404
  end

  def show 
    item = Item.find(params[:id])
    render json: item 
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Item not found" }, status: 404
  end

  def create 
    user = User.find(params[:user_id])
    item = user.items.create!(params.permit(:name, :description, :price))
    render json: item, status: :created
  end

end
