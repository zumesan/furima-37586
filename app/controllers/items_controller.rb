class ItemsController < ApplicationController
<<<<<<< Updated upstream
  
=======
  before_action :authenticate_user!, only: [:new, :create] #ログインしていないユーザーが出品しようとすると、ログイン画面に遷移する

>>>>>>> Stashed changes
  def index
    
  end

<<<<<<< Updated upstream
  #def new
    
  #end
=======
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
>>>>>>> Stashed changes

end
