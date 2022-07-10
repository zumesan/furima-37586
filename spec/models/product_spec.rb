require 'rails_helper'
RSpec.describe Product, type: :model do
  before do
    @product = FactoryBot.build(:product)
  end

  describe '商品情報登録' do
    context '商品が出品できる場合' do
      it 'product_nameとproduct_infoとcategory_idとstate_idとshipping_fee_idとprefecture_idとdate_of_shipping_idとpriceとimageが存在していれば保存できる' do
        expect(@product).to be_valid
      end
    end
    context '商品が出品できない場合' do
      it 'product_nameが空では保存できない' do
        @product.product_name = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Product name can't be blank")
      end
      it 'product_infoが空だと保存できない' do
        @product.product_info = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Product info can't be blank")
      end
      it 'category_idが1だと保存できない' do
        @product.category_id = '1'
        @product.valid?
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end
      it 'state_idが1だと保存できない' do
        @product.state_id = '1'
        @product.valid?
        expect(@product.errors.full_messages).to include("State can't be blank")
      end
      it 'shipping_fee_idが1だと保存できない' do
        @product.shipping_fee_id = '1'
        @product.valid?
        expect(@product.errors.full_messages).to include("Shipping fee can't be blank")
      end
      it 'prefecture_idが1だと保存できない' do
        @product.prefecture_id = '1'
        @product.valid?
        expect(@product.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'date_of_shipping_idが1だと保存できない' do
        @product.date_of_shipping_id = '1'
        @product.valid?
        expect(@product.errors.full_messages).to include("Date of shipping can't be blank")
      end
      it 'priceが空だと保存できない' do
        @product.price = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Price is not a number", "Price is invalid")
      end
      it 'priceが300未満だと保存できない' do
        @product.price = '299'
        @product.valid?
        expect(@product.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it 'priceが10000000以上だと保存できない' do
        @product.price = '10000000'
        @product.valid?
        expect(@product.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
      it 'priceが大文字だと保存できない' do
          @product.price = '３０００'
          @product.valid?
          expect(@product.errors.full_messages).to include("Price is not a number")
      end
      it 'priceが数値でなければ保存できない' do
          @product.price = '三千'
          @product.valid?
          expect(@product.errors.full_messages).to include("Price is not a number")
      end
      it 'imageが空だと保存できない' do
          @product.image = nil
          @product.valid?
          expect(@product.errors.full_messages).to include("Image can't be blank")
      end
    end
  end
end
