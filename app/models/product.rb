class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to :category
  belongs_to :state
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :date_of_shipping
  has_one :purchase_record
  has_many_attached :images
  has_many :comments

  #空の投稿を保存できないようにする
  validates :product_name, :product_info, presence: true
  validates :images, presence: {message: "を選択してください"}
  validates :images, length: { minimum: 1, maximum: 5, message: "は1枚以上5枚以下にしてください" }

  #ここからセレクトボックスで「---」を選択していると保存できないバリデーション
  validates :category_id, numericality: { other_than: 1 ,message: "を選択してください" } #エラーメッセージを"can't be blank"に編集
  validates :state_id, numericality: { other_than: 1 ,message: "を選択してください" } 
  validates :shipping_fee_id, numericality: { other_than: 1 ,message: "を選択してください" }
  validates :prefecture_id, numericality: { other_than: 1 ,message: "を選択してください" }
  validates :date_of_shipping_id, numericality: { other_than: 1 ,message: "を選択してください" }
  #ここまでセレクトボックスで「---」を選択していると保存できないバリデーション
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, allow_blank:true },format: { with: /\A[0-9]+\z/, allow_blank:true }, presence: true#数値かつ半角のみのバリデーション

end
