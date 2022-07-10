class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to :category
  belongs_to :state
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :date_of_shipping
  #has_one :purchase_record
  has_one_attached :image

  #空の投稿を保存できないようにする
  validates :product_name, :product_info, presence: true
  validates :image, presence:true 

  #ここからセレクトボックスで「---」を選択していると保存できないバリデーション
  validates :category_id, numericality: { other_than: 1 ,message: "can't be blank" } #エラーメッセージを"can't be blank"に編集
  validates :state_id, numericality: { other_than: 1 ,message: "can't be blank" } 
  validates :shipping_fee_id, numericality: { other_than: 1 ,message: "can't be blank" }
  validates :prefecture_id, numericality: { other_than: 1 ,message: "can't be blank" }
  validates :date_of_shipping_id, numericality: { other_than: 1 ,message: "can't be blank" }
  #ここまでセレクトボックスで「---」を選択していると保存できないバリデーション
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, allow_blank:true },format: { with: /\A[0-9]+\z/, allow_blank:true }, presence: true#数値かつ半角のみのバリデーション

end
