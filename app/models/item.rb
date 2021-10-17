class Item < ApplicationRecord
  
  with_options presence: true do
    validates :item_name
    validates :item_info
  end

  with_options numericality: { other_than: 0, message: "can't be blank" } do
    validates :category_id
    validates :status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :delivery_schedule_id
  end

  validates :price, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 300,
    less_than_or_equal_to: 9999999
  }

  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :delivery_schedule

end
