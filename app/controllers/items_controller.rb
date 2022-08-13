class ItemsController < ApplicationController
  before_action :set_product, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show] #ログインしていないユーザーが出品しようとすると、ログイン画面に遷移する。※except:・・・指定したアクション以外でメソッドを実施
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]

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

  def show
    @comments = @product.comments.includes(:user)
    @comment = Comment.new
  end

  def edit
    if @product.purchase_record_id.present?
      redirect_to root_path
    end
  end

  def update
    if @product.update(product_params)
      redirect_to item_path(@product)
    else
      render :edit
    end
  end

  def destroy
    product = Product.find(params[:id])
    if product.destroy
      redirect_to root_path
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:product_name, :product_info, :price, :category_id, :state_id, :shipping_fee_id, :prefecture_id, :date_of_shipping_id, {images: []}).merge(user_id: current_user.id) #permitメソッドで、（）内の情報の編集を許可する
  end

  def contributor_confirmation
    redirect_to root_path unless current_user == @product.user
    
  end

end
