class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products
  has_many :purchase_records

  VALID_PASSWORD_REGEX = /(?=.[a-zA-Z])(?=.\d)[a-zA-Z\d]{7,}/
  FULL_WIDTH = "is invalid. Input full-width characters"
  FULL_WIDTH_KANA = "is invalid. Input full-width katakana characters"

  validates :nickname, presence:true
  validates :password,length: { minimum:6, allow_blank: true },format:{with: VALID_PASSWORD_REGEX, message:"is invalid. Include both letters and numbers" }
  validates :first_name, presence:true, format:{with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/,message:FULL_WIDTH}
  validates :last_name, presence:true, format:{with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/,message:FULL_WIDTH}
  validates :first_name_kana, presence:true, format:{with: /\A[ァ-ヴー]+\z/u,message:FULL_WIDTH_KANA}
  validates :last_name_kana, presence:true, format:{with: /\A[ァ-ヴー]+\z/u,message:FULL_WIDTH_KANA}
  validates :birth_date, presence:true
end
