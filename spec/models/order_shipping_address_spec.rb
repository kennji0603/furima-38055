require 'rails_helper'

RSpec.describe OrderShippingAddress, type: :model do
  describe '購入情報の保存' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.build(:item)
      @item.save
      sleep 0.1
      @order_shipping_address = FactoryBot.build(:order_shipping_address, user_id: @user.id, item_id: @item.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_shipping_address).to be_valid
      end

      it 'building_nameは空でも保存できること' do
        @order_shipping_address.building_name = ''
        expect(@order_shipping_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できないこと' do
        @order_shipping_address.postal_code = ''
        @order_shipping_address.valid?
   
        expect(@order_shipping_address.errors.full_messages).to include "郵便番号を入力してください"
      end

      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_shipping_address.postal_code = '1234567'
        @order_shipping_address.valid?
      
        expect(@order_shipping_address.errors.full_messages).to include "郵便番号はハイフンを入れて入力してください"
      end

      it 'prefecture_idを選択していないと保存できないこと' do
        @order_shipping_address.prefecture_id = 1
        @order_shipping_address.valid?

        expect(@order_shipping_address.errors.full_messages).to include "都道府県を選択してください"
      end

      it 'cityが空だと保存できないこと' do
        @order_shipping_address.city = ''
        @order_shipping_address.valid?

        expect(@order_shipping_address.errors.full_messages).to include "市町村を入力してください"
      end

      it 'house_numberが空だと保存できないこと' do
        @order_shipping_address.house_number = ''
        @order_shipping_address.valid?
        
        expect(@order_shipping_address.errors.full_messages).to include "番地を入力してください"
      end

      it 'phone_numberが空だと保存できない' do
        @order_shipping_address.phone_number = ''
        @order_shipping_address.valid?

        expect(@order_shipping_address.errors.full_messages).to include "電話番号を入力してください"
      end

      it 'phone_numberが10桁未満だと保存できない' do
        @order_shipping_address.phone_number = '090111111'
        @order_shipping_address.valid?
       
        expect(@order_shipping_address.errors.full_messages).to include "電話番号は半角数字で入力してください"
      end

      it 'phone_numberが11桁を超えていると保存できない' do
        @order_shipping_address.phone_number = '090111111111'
        @order_shipping_address.valid?
     
        expect(@order_shipping_address.errors.full_messages).to include "電話番号は半角数字で入力してください"
      end

      it 'phone_numberが全角数字だと保存できない' do
        @order_shipping_address.phone_number = '０９０１１１１１１１１'
        @order_shipping_address.valid?
       
        expect(@order_shipping_address.errors.full_messages).to include "電話番号は半角数字で入力してください"
      end

      it 'phone_numberがハイフンを含んだ形だと保存できない' do
        @order_shipping_address.phone_number = '090-1111-1111'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "電話番号は半角数字で入力してください"
      end

      it 'userが紐ついてないと保存できない' do
        @order_shipping_address.user_id = nil
        @order_shipping_address.valid?
  
        expect(@order_shipping_address.errors.full_messages).to include "Userを入力してください"
      end

      it 'itemが紐ついてないと保存できない' do
        @order_shipping_address.item_id = nil
        @order_shipping_address.valid?
        
        expect(@order_shipping_address.errors.full_messages).to include "Itemを入力してください"
      end

      it 'tokenが空では保存できないこと' do
        @order_shipping_address.token = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "クレジットカード情報を入力してください"
      end
    end
  end
end
