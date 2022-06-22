class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname, :birthday, :password_confirmation
    validates :first_name, :last_name,
              format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は、全角文字で入力してください' }
    validates :first_name_reading, :last_name_reading,
              format: { with: /\A[ァ-ヶー]+\z/, message: 'は、全角カタカナで入力してください' }
  end
  validates :password, :password_confirmation,
            format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'は、半角英数字で入力してください' }

  has_many :items
  has_many :orders
  has_many :comments
end
