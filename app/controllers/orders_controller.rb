class OrdersController < ApplicationController

  def index
    @product = Product.find(params[:item_id])
  end

  def create
  end

end
