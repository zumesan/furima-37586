class OrdersController < ApplicationController

  before_action :set_product, only: :index
  before_action :authenticate_user!, only: [:index, :create]
  before_action :contributor_confirmation, only: [:index, :create]

  def index

  end

  def create
  end


  private

  def set_product
    @product = Product.find(params[:item_id])
  end

  def contributor_confirmation
    redirect_to root_path if current_user == @product.user
  end

end
