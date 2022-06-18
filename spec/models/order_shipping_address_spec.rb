require 'rails_helper'

RSpec.describe OrderShippingAddress, type: :model do
  describe '購入情報の保存' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.build(:item)
      @item.image = fixture_file_upload('public/images/test_image.png')
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
        expect(@order_shipping_address.errors.full_messages).to include "Postal code can't be blank", "Postal code is invalid. Include hyphen(-)"
      end

      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_shipping_address.postal_code = '1234567'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "Postal code is invalid. Include hyphen(-)"
      end

      it 'prefecture_idを選択していないと保存できないこと' do
        @order_shipping_address.prefecture_id = 1
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "Prefecture can't be blank"
      
      end

      it 'cityが空だと保存できないこと' do
        @order_shipping_address.city = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "City can't be blank"
      end

      it 'house_numberが空だと保存できないこと' do
        @order_shipping_address.house_number = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "House number can't be blank"
      end

      it 'phone_numberが空だと保存できない' do
        @order_shipping_address.phone_number = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "Phone number can't be blank",
        "Phone number is invalid. Input half-width characters."
      end

      it 'phone_numberが10桁未満だと保存できない' do
        @order_shipping_address.phone_number = '090111111'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "Phone number is invalid. Input half-width characters."
      end

      it 'phone_numberが11桁を超えていると保存できない' do
         @order_shipping_address.phone_number = '090111111111'
         @order_shipping_address.valid?
         expect(@order_shipping_address.errors.full_messages).to include "Phone number is invalid. Input half-width characters."
      end

      it 'phone_numberが全角数字だと保存できない' do
        @order_shipping_address.phone_number = '０９０１１１１１１１１'
         @order_shipping_address.valid?
         expect(@order_shipping_address.errors.full_messages).to include "Phone number is invalid. Input half-width characters."
      end

      it 'phone_numberがハイフンを含んだ形だと保存できない' do
         @order_shipping_address.phone_number = '090-1111-1111'
         @order_shipping_address.valid?
         expect(@order_shipping_address.errors.full_messages).to include "Phone number is invalid. Input half-width characters."
      end

      it 'userが紐ついてないと保存できない' do
        @order_shipping_address.user_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "User can't be blank"
      end

      it 'itemが紐ついてないと保存できない' do
        @order_shipping_address.item_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "Item can't be blank"
      end
    end
  end
    
end
