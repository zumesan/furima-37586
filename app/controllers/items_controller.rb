class ItemsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create] #ログインしていないユーザーが出品しようとすると、ログイン画面に遷移する

  def index
    @products = Product.all.order(created_at: :desc)
  end


  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
      if @product.save
        redirect_to root_path
      else
        render :new
      end
  end

  private

  def product_params
    params.require(:product).permit(:product_name, :product_info, :price, :category_id, :state_id, :shipping_fee_id, :prefecture_id, :date_of_shipping_id, :image).merge(user_id: current_user.id)
  end

end
