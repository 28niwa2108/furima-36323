class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code,
                :prefecture_id,
                :city,
                :address,
                :building,
                :phone_number,
                :order_id,
                :user_id,
                :item_id,
                :token

  with_options presence: true do
    validates :postal_code, format: {
      with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)"
    }
    validates :prefecture_id, numericality: {
      other_than: 0, message: "can't be blank"
    }
    validates :city
    validates :address
    validates :phone_number, length: { in: 10..11 }, format: {
      with: /\A[0-9]+\z/, message: "is invalid. Input only number"
    }
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      address: address,
      building: building,
      phone_number: phone_number,
      order_id: order.id
    )
  end
end
