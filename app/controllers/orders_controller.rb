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
      pay_item
      @purchase_destination.save
      return redirect_to root_path
    else
      render 'index'
    end
  end


  private

  def set_product
   @product = Product.find(params[:item_id])
  end

  def record_params
    params.require(:purchase_destination).permit(:post_number, :prefecture_id, :municipality, :address, :building_name, :phone_number).merge(token: params[:token],user_id: current_user.id, product_id: params[:item_id])
  end

  def contributor_confirmation
    redirect_to root_path if current_user == @product.user
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  #環境変数で設定したPAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: @product.price,         #商品の値段
      card: record_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

end
