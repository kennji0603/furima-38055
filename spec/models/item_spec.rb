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
        expect(@item.errors.full_messages).to include "商品名を入力してください"
      end

      it 'explanationが空では出品できない' do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "商品説明を入力してください"
      end

      it 'imageが空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "画像を入力してください"
      end

      it 'priceが空では出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "金額を入力してください", "金額は半角数字で、¥300〜9,999,999の間で設定してください"
      end

      it 'priceが300円未満だと出品できない' do
        @item.price = 0
        @item.valid?
        
        expect(@item.errors.full_messages).to include "金額は半角数字で、¥300〜9,999,999の間で設定してください"
      end

      it 'priceが10,000,000円以上だと出品できない' do
        @item.price = 10_000_001
        @item.valid?
       
        expect(@item.errors.full_messages).to include "金額は半角数字で、¥300〜9,999,999の間で設定してください"
      end

      it 'priceが全角数字では出品できない' do
        @item.price = '５００'
        @item.valid?
       
        expect(@item.errors.full_messages).to include "金額は半角数字で、¥300〜9,999,999の間で設定してください"
      end

      it 'category_idが選択されていなければ出品できない' do
        @item.category_id = 1
        @item.valid?
        
        expect(@item.errors.full_messages).to include "カテゴリーを選択してください"
      end

      it 'condition_idが選択されていなければ出品できない' do
        @item.condition_id = 1
        @item.valid?
       
        expect(@item.errors.full_messages).to include "商品の状態を選択してください"
      end

      it 'postagetype_id が選択されていなければ出品できない' do
        @item.postagetype_id = 1
        @item.valid?
        
        expect(@item.errors.full_messages).to include "配送料の負担を選択してください"
      end

      it 'prefecture_id が選択されていなければ出品できない' do
        @item.prefecture_id = 1
        @item.valid?
      
        expect(@item.errors.full_messages).to include "発送元の地域を選択してください"
      end

      it 'preparationday_id が選択されていなければ出品できない' do
        @item.preparationday_id = 1
        @item.valid?
        
        expect(@item.errors.full_messages).to include "発送までの日数を選択してください"
      end

      it 'userが紐ついてないと出品できない' do
        @item.user = nil
        @item.valid?
      
        expect(@item.errors.full_messages).to include "Userを入力してください"
      end
    end
  end
end
