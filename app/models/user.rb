class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products
  has_many :purchase_records

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i #半角英数のバリデーション
  VALID_PASSWORD_REGEX.freeze #freezeで変数の内容を固定
  FULL_WIDTH = "is invalid. Input full-width characters"
  FULL_WIDTH_KANA = "is invalid. Input full-width katakana characters" #全角カナ文字のバリデーション

  validates :nickname, presence:true
  validates :password,length: { minimum:6, allow_blank: true },format:{with: VALID_PASSWORD_REGEX, message:"is invalid. Include both letters and numbers" }
  #ここから全角文字のバリデーション
  validates :first_name, presence:true, format:{with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/,message:FULL_WIDTH}
  validates :last_name, presence:true, format:{with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/,message:FULL_WIDTH}
  #ここまで全角文字のバリデーション
  #ここから全角カナ文字のバリデーション
  validates :first_name_kana, presence:true, format:{with: /\A[ァ-ヴー]+\z/u,message:FULL_WIDTH_KANA}
  validates :last_name_kana, presence:true, format:{with: /\A[ァ-ヴー]+\z/u,message:FULL_WIDTH_KANA}
  #ここまで全角カナ文字のバリデーション
  validates :birth_date, presence:true
end
