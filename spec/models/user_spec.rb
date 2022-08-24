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
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
      end
      it 'emailに@が含まれていなければ登録できない' do
        @user.email = 'aaaicloud.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスは不正な値です")
      end
      it '重複したemailがある場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("メールアドレスはすでに存在します")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください", "パスワードは半角英数字で入力してください", "Password confirmationとパスワードの入力が一致しません")
      end
      it 'passwordは半角英字のみでは登録できない' do
        @user.password = "aaaaaa"
        @user.password_confirmation = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数字で入力してください")
      end
      it 'passwordは半角数字のみでは登録できない' do
        @user.password = "000000"
        @user.password_confirmation = "000000"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数字で入力してください")
      end
      it 'passwordは全角では登録できない' do
        @user.password = "AAA０００"
        @user.password_confirmation = "AAA０００"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数字で入力してください")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = "11aaa"
        @user.password_confirmation = "11aaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = "123456"
        @user.password_confirmation = "1234567"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmationとパスワードの入力が一致しません", "パスワードは半角英数字で入力してください")
      end
      it 'first_namaが空だと登録できない' do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください", "名前は全角で入力してください")
      end
      it 'last_namaが空だと登録できない' do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字を入力してください", "苗字は全角で入力してください")
      end
      it 'first_nama_kanaが空だと登録できない' do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（カナ）を入力してください", "名前（カナ）は全角カタカナで入力してください")
      end
      it 'last_nama_kanaが空だと登録できない' do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字（カナ）を入力してください", "苗字（カナ）は全角カタカナで入力してください")
      end
      it 'first_namaが全角文字でなければ登録できない' do
        @user.first_name = "kuru"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は全角で入力してください")
      end
      it 'last_namaが全角文字でなければ登録できない' do
        @user.last_name = "nekoyashiki"
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字は全角で入力してください")
      end
      it 'first_nama_kanaが全角カナ文字でなければ登録できない' do
        @user.first_name_kana = "kuru"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（カナ）は全角カタカナで入力してください")
      end
      it 'last_nama_kanaが全角カナ文字でなければ登録できない' do
        @user.last_name_kana = "kuru"
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字（カナ）は全角カタカナで入力してください")
      end
      it 'birth_dateが空の場合は登録できない' do
        @user.birth_date = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end