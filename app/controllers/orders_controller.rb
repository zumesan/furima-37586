class OrdersController < ApplicationController

  before_action :set_product, only: [:index, :create]
  before_action :authenticate_user!, only: [:index, :create]
  before_action :contributor_confirmation, only: [:index, :create]

  def index
    @purchase_destination = PurchaseDestination.new
  end

  def create
    @purchase_destination = PurchaseDestination.new(record_params)
    if @purchase_destination.valid?
      redirect_to root_path
    else
      render 'index'
    end
  end


  private

  def record_params
    params.require(:purchase_destination).permit(:post_number, :prefecture_id, :municiplity, :address, :building_name, :phone_number)
  end

  def set_product
    @product = Product.find(params[:item_id])
  end

  def contributor_confirmation
    redirect_to root_path if current_user == @product.user
  end

end
