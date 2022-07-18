class PurchaseDestination
  include ActiveModel::Model
  attr_accessor :post_number, :municiplity, :address, :building_name, :phone_number, :purchase_record, :prefecture_id

  VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/
  FULL_WIDTH_CHARACTERS = /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/

  with_options presence: true do
    validates :post_number, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "Include hyphen(-)", allow_blank:true} 
    validates :prefecture_id ,numericality: { other_than: 1 ,message: "Select" }
    validates :municiplity, format: {with: FULL_WIDTH_CHARACTERS, message:"is invalid. Input full-width characters", allow_blank:true}
    validates :address
    validates :phone_number, numericality: {message: "Input only number"}, format:{ with: VALID_PHONE_REGEX, allow_blank:true }
  end

  def save #テーブルへの保存の記述
    PurchaseRecord.create(user: user, product: product)
    Destination.create(post_number: post_number, prefecture_id: prefecture_id, municiplity:municiplity, address:address, building_name: building_name, phone_number: phone_number)
  end

end