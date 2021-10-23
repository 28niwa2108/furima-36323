require 'rails_helper'

RSpec.describe '商品出品機能', type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  context '商品出品ができるケース' do
    it '全てのカラムに正しい値が存在すれば出品できる' do
      expect(@item).to be_valid
    end

    it 'category_idが0以外の数字なら出品できる' do
      @item.category_id = 1
      expect(@item).to be_valid
    end

    it 'status_idが0以外の数字なら出品できる' do
      @item.status_id = 1
      expect(@item).to be_valid
    end

    it 'shipping_fee_status_idが0以外の数字なら出品できる' do
      @item.shipping_fee_status_id = 1
      expect(@item).to be_valid
    end

    it 'prefecture_idが0以外の数字なら出品できる' do
      @item.prefecture_id = 1
      expect(@item).to be_valid
    end

    it 'delivery_schedule_idが0以外の数字なら出品できる' do
      @item.delivery_schedule_id = 1
      expect(@item).to be_valid
    end

    it 'priceが300以上(~9999999の範囲内)の数字なら出品できる' do
      @item.price = 300
      expect(@item).to be_valid
    end

    it 'priceが(300以上)~9999999以下の数字なら出品できる' do
      @item.price = 9_999_999
      expect(@item).to be_valid
    end

    it 'ユーザーが存在すれば出品できる' do
      expect(@item.user).to be_truthy
      expect(@item).to be_valid
    end
  end

  context '商品出品ができないケース' do
    it 'item_nameが空では出品できない' do
      @item.item_name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Item name can't be blank")
    end

    it 'item_infoが空では出品できない' do
      @item.item_info = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Item info can't be blank")
    end

    it 'imageが空では出品できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it 'priceが空では出品できない' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end

    it 'userが存在しないと出品できない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("User must exist")
    end

    it 'category_idが0(初期値)では出品できない' do
      @item.category_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
    end

    it 'status_idが0(初期値)では出品できない' do
      @item.status_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include("Status can't be blank")
    end

    it 'shipping_fee_status_idが0(初期値)では出品できない' do
      @item.shipping_fee_status_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include("Shipping fee status can't be blank")
    end

    it 'prefecture_idが0(初期値)では出品できない' do
      @item.prefecture_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include("Prefecture can't be blank")
    end

    it 'delivery_schedule_idが0(初期値)では出品できない' do
      @item.delivery_schedule_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include("Delivery schedule can't be blank")
    end

    it 'category_idが半角数値でなければ出品できない' do
      @item.category_id = '１'
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
    end

    it 'status_idが半角数値でなければ出品できない' do
      @item.status_id = '１'
      @item.valid?
      expect(@item.errors.full_messages).to include("Status can't be blank")
    end

    it 'shipping_fee_status_idが半角数値でなければ出品できない' do
      @item.shipping_fee_status_id = '１'
      @item.valid?
      expect(@item.errors.full_messages).to include("Shipping fee status can't be blank")
    end

    it 'prefecture_idが半角数値でなければ出品できない' do
      @item.prefecture_id = '１'
      @item.valid?
      expect(@item.errors.full_messages).to include("Prefecture can't be blank")
    end

    it 'delivery_schedule_idが半角数値でなければ出品できない' do
      @item.delivery_schedule_id = '１'
      @item.valid?
      expect(@item.errors.full_messages).to include("Delivery schedule can't be blank")
    end

    it 'priceが半角数値でなければ出品できない' do
      @item.price = '１０００'
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not a number")
    end

    it 'priceが300未満では出品できない' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
    end

    it 'priceが9999999を超えると出品できない' do
      @item.price = 99_999_991
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
    end
  end
end
