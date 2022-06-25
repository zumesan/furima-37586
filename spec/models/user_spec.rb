require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmation、名前（全角）と名前カナ（全角）、生年月日が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'emailに@が含まれていなければ登録できない' do
        @user.email = 'aaaicloud.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it '重複したemailがある場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordは英数混合でないと登録できない' do
        @user.password = "000000"
        @user.password_confirmation = "000000"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = "11aaa"
        @user.password_confirmation = "11aaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = "123456"
        @user.password_confirmation = "1234567"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'first_namaが全角文字でなければ登録できない' do
        @user.first_name = "kuru"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters")
      end
      it 'last_namaが全角文字でなければ登録できない' do
        @user.last_name = "nekoyashiki"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid. Input full-width characters")
      end
      it 'first_nama_kanaが全角カナ文字でなければ登録できない' do
        @user.first_name_kana = "kuru"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid. Input full-width katakana characters")
      end
      it 'last_nama_kanaが全角カナ文字でなければ登録できない' do
        @user.last_name_kana = "kuru"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")
      end
      it 'birth_dateが空の場合は登録できない' do
        @user.birth_date = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end