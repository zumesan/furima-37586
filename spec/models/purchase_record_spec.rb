require 'rails_helper'

RSpec.describe PurchaseRecord, type: :model do
  before do
    @purchase_record = FactoryBot.build(:purchase_record)
  end

  describe '商品購入履歴登録' do
    context '商品購入履歴が登録できる場合' do
      it 'user_idとproduct_idが存在していれば保存できる' do
        expect(@purchase_record).to be_valid
      end
    end
  end
end
