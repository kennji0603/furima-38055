class ShippingAddress < ApplicationRecord
  belongs_to :order
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
 
  with_options presence: true do
    validates :city, :house_number
  end

  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/, message: 'is invalid. Input half-width characters.' }
  end

  with_options presence: true do
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input half-width characters.' }
  end
end

