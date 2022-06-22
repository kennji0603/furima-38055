class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_one :order
  has_many :comments, dependent: :destroy
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :postagetype
  belongs_to :prefecture
  belongs_to :preparationday

  with_options presence: true do
    validates :name, :explanation, :image
  end

  with_options presence: true do
    validates :price,
              numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: "は半角数字で、¥300〜9,999,999の間で設定してください" }
  end

  validates :category_id, :condition_id, :postagetype_id, :prefecture_id, :preparationday_id,
            numericality: { other_than: 1, message: "を選択してください" }
end
