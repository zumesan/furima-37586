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
      it 'ユーザー情報がない場合は登録できない' do
        @product.user = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Userを入力してください")
      end
      it 'product_nameが空では保存できない' do
        @product.product_name = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("商品名を入力してください")
      end
      it 'product_infoが空だと保存できない' do
        @product.product_info = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("商品の説明を入力してください")
      end
      it 'category_idが1だと保存できない' do
        @product.category_id = '1'
        @product.valid?
        expect(@product.errors.full_messages).to include("カテゴリーを選択してください")
      end
      it 'state_idが1だと保存できない' do
        @product.state_id = '1'
        @product.valid?
        expect(@product.errors.full_messages).to include("商品の状態を選択してください")
      end
      it 'shipping_fee_idが1だと保存できない' do
        @product.shipping_fee_id = '1'
        @product.valid?
        expect(@product.errors.full_messages).to include("発送料の負担を選択してください")
      end
      it 'prefecture_idが1だと保存できない' do
        @product.prefecture_id = '1'
        @product.valid?
        expect(@product.errors.full_messages).to include("発送元の地域を選択してください")
      end
      it 'date_of_shipping_idが1だと保存できない' do
        @product.date_of_shipping_id = '1'
        @product.valid?
        expect(@product.errors.full_messages).to include("発送までの日数を選択してください")
      end
      it 'priceが空だと保存できない' do
        @product.price = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("販売価格を入力してください")
      end
      it 'priceが300未満だと保存できない' do
        @product.price = '299'
        @product.valid?
        expect(@product.errors.full_messages).to include("販売価格は300以上の値にしてください")
      end
      it 'priceが10000000以上だと保存できない' do
        @product.price = '10000000'
        @product.valid?
        expect(@product.errors.full_messages).to include("販売価格は9999999以下の値にしてください")
      end
      it 'priceが大文字だと保存できない' do
          @product.price = '３０００'
          @product.valid?
          expect(@product.errors.full_messages).to include("販売価格は数値で入力してください")
      end
      it 'priceが数値でなければ保存できない' do
          @product.price = '三千'
          @product.valid?
          expect(@product.errors.full_messages).to include("販売価格は数値で入力してください")
      end
      it 'imageが空だと保存できない' do
          @product.images = nil
          @product.valid?
          expect(@product.errors.full_messages).to include("画像を選択してください","画像は1枚以上5枚以下にしてください")
      end
    end
  end
end
