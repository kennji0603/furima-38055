class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, :condition, :postagetype, :prefecture, :preparationday

  with_options presence: true do
    validates :name, :explanation, :image
  end

  with_options presence: true do
    validates :price,
              numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  end

  validates :category_id, :condition_id, :postagetype_id, :prefecture_id, :preparationday_id,
            numericality: { other_than: 1, message: "can't be blank" }
end
