class PurchaseDestination
  include ActiveModel::Model
  attr_accessor :user_id, :product_id, :post_number, :token, :municipality, :address, :building_name, :phone_number, :purchase_record_id, :prefecture_id

  VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/
  FULL_WIDTH_CHARACTERS = /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/

  with_options presence: true do
    validates :token
    validates :post_number, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, allow_blank:true}
    validates :prefecture_id ,numericality: { other_than: 1 ,message: "を選択してください" }
    validates :municipality
    validates :address
    validates :phone_number, numericality: {message: "は半角数字で入力してください"}, format:{ with: VALID_PHONE_REGEX, allow_blank:true }
    validates :user_id
    validates :product_id
  end

  def save #テーブルへの保存の記述
    purchase_record = PurchaseRecord.create(user_id: user_id, product_id: product_id) #ordersコントローラーで定義されたuser_idとproduct_idを取得し、変数purchase_recordに格納
    Destination.create(post_number: post_number, prefecture_id: prefecture_id, municipality:municipality, address:address, building_name: building_name, phone_number: phone_number, purchase_record_id: purchase_record.id)
    @purchase = Product.find(product_id)
    @purchase.update(purchase_record_id: purchase_record.id)
  end

end