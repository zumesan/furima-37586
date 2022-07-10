class ItemsController < ApplicationController

  def index
    
  end

  def new
    if user_signed_in?
      @product = Product.new
    else
      redirect_to new_user_session_path
    end
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
