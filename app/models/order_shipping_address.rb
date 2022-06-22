class OrderShippingAddress
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :postal_code, :city, :house_number, :building_name, :phone_number, :prefecture_id, :token

  with_options presence: true do
    validates :token, :city, :house_number, :user_id, :item_id
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'はハイフンを入れて入力してください' }
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'は半角数字で入力してください' }
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "を選択してください" }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number,
                           building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end
