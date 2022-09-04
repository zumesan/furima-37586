require 'rails_helper'

RSpec.describe PurchaseDestination, type: :model do
  before do
    product = FactoryBot.create(:product)
    user = product.user_id
    @purchase_destination = FactoryBot.build(:purchase_destination, user_id: user, product_id: product.id)
    sleep 0.1
  end

  describe '商品購入履歴の登録' do
    context '購入履歴が登録できる場合' do
      it 'すべての値が正しく入力されていれば登録できる' do
        expect(@purchase_destination).to be_valid
      end
      it 'building_nameが空でも登録できる' do
        @purchase_destination.building_name = ''
        expect(@purchase_destination).to be_valid
      end
    end

    context '購入履歴が登録できない場合' do
      it 'user情報が紐づいていなければ登録できない'do
        @purchase_destination.user_id = nil
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Userを入力してください")
      end
      it 'product情報が紐づいていなければ登録できない' do
        @purchase_destination.product_id = nil
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Productを入力してください")
      end
      it 'tokenが空の場合は登録できない' do
        @purchase_destination.token = nil
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
      it 'post_numberが空では登録できない' do
        @purchase_destination.post_number = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("郵便番号を入力してください")
      end
      it 'post_numberに（-）がなければ登録できない' do
        @purchase_destination.post_number = '1234567'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it 'post_numberが数字以外では登録できない' do
        @purchase_destination.post_number = 'aaa-aaaa'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it 'post_numberは半角数字でなければ登録できない' do
        @purchase_destination.post_number = '１２３-４５６７'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it 'post_numberの（-）の前が3桁未満では登録できない' do
        @purchase_destination.post_number = '12-3456'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it 'post_numberの（-）の後ろが4桁未満では登録できない' do
        @purchase_destination.post_number = '123-456'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it 'post_numberの（-）の前が4桁以上では登録できない' do
        @purchase_destination.post_number = '1234-5678'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it 'post_numberの（-）の後ろが5桁以上では登録できない' do
        @purchase_destination.post_number = '123-45678'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it 'prefecture_idを選択しなければなければ登録できない' do
        @purchase_destination.prefecture_id = '1'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("都道府県を選択してください")
      end
      it 'municipalityが空では登録できない' do
        @purchase_destination.municipality = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("市区町村を入力してください")
      end
      it 'addressが空では登録できない' do
        @purchase_destination.address = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("番地を入力してください")
      end
      it 'phone_numberが空では登録できない' do
        @purchase_destination.phone_number = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("電話番号を入力してください")
      end
      it 'phone_numberが数字以外では登録できない' do
        @purchase_destination.phone_number = 'aaaaaaaaaaa'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("電話番号は半角数字で入力してください", "電話番号は不正な値です")
      end
      it 'phone_numberは半角数字でなけれは登録できない' do
        @purchase_destination.phone_number = '１２３４５６７８９０'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("電話番号は半角数字で入力してください", "電話番号は不正な値です")
      end
      it 'phone_numberは「-」がある場合は登録できない' do
        @purchase_destination.phone_number = '123-4567-8910'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("電話番号は半角数字で入力してください", "電話番号は不正な値です")
      end
      it 'phone_numberが10桁未満の場合は登録できない' do
        @purchase_destination.phone_number = '123456789'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("電話番号は不正な値です")
      end
      it 'phone_numberが12桁以上の場合は登録できない' do
        @purchase_destination.phone_number = '123456789012'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("電話番号は不正な値です")
      end
    end
  end
end