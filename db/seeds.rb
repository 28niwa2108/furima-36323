#Userデータ
require 'date'
users = []

users << User.new({
    id: 1, nickname: "セラー", email: "seller@gmail.com",
    password: "seller1", password_confirmation: "seller1",
    last_name: "世良", first_name: "太郎", last_name_kana: "セラ" ,first_name_kana: "タロウ",
    birth_date: Date.parse('1985-5-6')
})

users << User.new({
    id: 2, nickname: "バイヤー", email: "buyer@gmail.com",
    password: "buyer1", password_confirmation: "buyer1",
    last_name: "海田", first_name: "花子", last_name_kana: "カイタ" ,first_name_kana: "ハナコ",
    birth_date: Date.parse('1990-9-10')
})

User.import users, validate: true


#Itemデータ
items  = []

bicycle = Item.new(
  id: 1, item_name: "自転車", item_info: "ディスプレイ用のため、走行距離0kmです。 傷も、ほとんどございません。",
  category_id: 8, status_id: 3, shipping_fee_status_id: 1, prefecture_id: 12,
  delivery_schedule_id: 3 ,price: "12000", user_id: 1
)
bicycle.image.attach(io: File.open('db/img/bicycle.jpg'), filename: 'bicycle.jpg')
bicycle.save

pc = Item.new(
  id: 2, item_name: "PC", item_info: "メモリ：8GB、ストレージ：256GBです。",
  category_id: 7, status_id: 3, shipping_fee_status_id: 1, prefecture_id: 12,
  delivery_schedule_id: 2 ,price: "150000", user_id: 1
)
pc.image.attach(io: File.open('db/img/pc.jpg'), filename: 'pc.jpg')
pc.save

clock = Item.new(
  id: 3, item_name: "懐中時計", item_info: "年代物の懐中時計です。",
  category_id: 4, status_id: 4, shipping_fee_status_id: 2, prefecture_id: 20,
  delivery_schedule_id: 2 ,price: "2250", user_id: 1
)
clock.image.attach(io: File.open('db/img/clock.jpg'), filename: 'clock.jpg')
clock.save

cap = Item.new(
  id: 4, item_name: "ニット帽", item_info: "2つセットです。",
  category_id: 1, status_id: 1, shipping_fee_status_id: 2, prefecture_id: 20,
  delivery_schedule_id: 1 ,price: "550", user_id: 1
)
cap.image.attach(io: File.open('db/img/cap.jpg'), filename: 'cap.jpg')
cap.save

#Orderデータ
Order.create!(
  user_id: 2, item_id: 2
)


#Addresデータ
Address.create!(
  postal_code: "111-1111", prefecture_id: 35, city: "◯◯市", address: "５−５−１",
  phone_number: "1234567890", order_id: 1
)