class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products
  has_many :purchase_records
  has_many :comments

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i #半角英数のバリデーションの値を変数に格納
  VALID_PASSWORD_REGEX.freeze #freezeで変数の内容を固定
  FULL_WIDTH = "は全角で入力してください"
  FULL_WIDTH_KANA = "は全角カタカナで入力してください" #全角カナ文字のバリデーションのエラーメッセージを変数に格納

  validates :nickname, presence:true
  validates :password, format:{with: VALID_PASSWORD_REGEX, message:"は半角英数字で入力してください" } #半角英数のバリデーション
  #ここから全角文字のバリデーション
  validates :first_name, presence:true, format:{with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/,message:FULL_WIDTH}
  validates :last_name, presence:true, format:{with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/,message:FULL_WIDTH}
  #ここまで全角文字のバリデーション
  #ここから全角カナ文字のバリデーション
  validates :first_name_kana, presence:true, format:{with: /\A[ァ-ヴー]+\z/u,message:FULL_WIDTH_KANA}#全角カナ文字のバリデーション
  validates :last_name_kana, presence:true, format:{with: /\A[ァ-ヴー]+\z/u,message:FULL_WIDTH_KANA}#全角カナ文字のバリデーション
  #ここまで全角カナ文字のバリデーション
  validates :birth_date, presence:true
end
