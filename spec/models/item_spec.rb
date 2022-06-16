require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品出品ができるとき' do
      it 'すべての値が正しく入力されていれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品ができないとき' do
      it 'nameが空では出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Name can't be blank"
      end

      it 'explanationが空では出品できない' do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Explanation can't be blank"
      end

      it 'imageが空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Image can't be blank"
      end
      
      it 'priceが空では出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Price can't be blank", "Price is invalid", "Price is not a number"
      end
      
      it 'priceが300円未満だと出品できない' do
        @item.price = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be greater than or equal to 300"
      end
      
      it 'priceが10,000,000円以上だと出品できない' do
        @item.price = 10000001
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be less than or equal to 9999999"
      end

      it 'priceが全角数字では出品できない' do
        @item.price = '５００'
        @item.valid?
        expect(@item.errors.full_messages).to include "Price is not a number"
      end

      it 'category_idが選択されていなければ出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Category can't be blank"
      end

      it 'condition_idが選択されていなければ出品できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Condition can't be blank"
      end

      it 'postagetype_id が選択されていなければ出品できない' do
        @item.postagetype_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Postagetype can't be blank"
      end
      
      it 'prefecture_id が選択されていなければ出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Prefecture can't be blank"
      end

      it 'preparationday_id が選択されていなければ出品できない' do
        @item.preparationday_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Preparationday can't be blank"
      end

      it 'userが紐ついてないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "User must exist"
      end
    end
  end


end
