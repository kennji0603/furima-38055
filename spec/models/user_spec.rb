require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録ができるとき' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空では保存できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "ニックネームを入力してください"
      end

      it 'メールアドレスが空では保存できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Eメールを入力してください"
      end

      it 'メールアドレスに@がないと保存できない' do
        @user.email = 'sample'
        @user.valid?
        expect(@user.errors.full_messages).to include "Eメールは不正な値です"
      end

      it 'メールアドレスが重複していると保存できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include "Eメールはすでに存在します"
      end

      it 'passwordが空だと保存できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードを入力してください"
      end

      it 'passwordとpassword_confirmationが一致していなければ保存できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード（確認用）とパスワードの入力が一致しません"
      end

      it 'passwordが5文字以下だと保存できない' do
        @user.password = 'aaaaa'
        @user.password_confirmation = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードは6文字以上で入力してください"
      end

      it 'passwordが129文字以上では保存できない' do
        @user.password = Faker::Lorem.characters(number: 129, min_alpha: 1, min_numeric: 1)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードは128文字以内で入力してください"
      end

      it '英字のみのpasswordでは保存できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードは、半角英数字で入力してください", "パスワード（確認用）は、半角英数字で入力してください"
      end

      it '数字のみのpasswordでは保存できない' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードは、半角英数字で入力してください", "パスワード（確認用）は、半角英数字で入力してください"
      end

      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'AAAAAA'
        @user.password_confirmation = 'AAAAAA'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードは、半角英数字で入力してください", "パスワード（確認用）は、半角英数字で入力してください"
      end

      it 'first_nameが空では保存できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "名前を入力してください"
      end

      it 'first_nameが全角でないと保存できない' do
        @user.first_name = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include "名前は、全角文字で入力してください"
      end

      it 'last_nameが空では保存できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "苗字を入力してください"
      end

      it 'last_nameが全角でないと保存できない' do
        @user.last_name = 'ｽｽﾞｷ'
        @user.valid?
        expect(@user.errors.full_messages).to include "苗字は、全角文字で入力してください"
      end

      it 'first_name_readingが空では保存できない' do
        @user.first_name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "名前カナを入力してください"
      end

      it 'first_name_readingが全角カナでないと保存できない' do
        @user.first_name_reading = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include "名前カナは、全角カタカナで入力してください"
      end

      it 'last_name_readingが空では保存できない' do
        @user.last_name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "苗字カナを入力してください"
      end

      it 'last_name_readingが全角カナでないと保存できない' do
        @user.last_name_reading = 'ｽｽﾞｷ'
        @user.valid?
        expect(@user.errors.full_messages).to include "苗字カナは、全角カタカナで入力してください"
      end

      it 'birthdayが空では保存できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "生年月日を入力してください"
      end
    end
  end
end
