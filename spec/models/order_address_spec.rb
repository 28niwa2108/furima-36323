require 'rails_helper'

RSpec.describe '商品購入機能', type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
    sleep 0.1
  end

  context '商品購入ができるとき' do
    it '全てのフォームに正しい値が入力されれば購入できる' do
      expect(@order_address).to be_valid
    end

    it 'postal_codeが3桁ハイフン4桁の半角数値なら購入できる' do
      @order_address.postal_code = '123-1234'
      expect(@order_address).to be_valid
    end

    it 'prefecture_idが0以外(47以下)の数字なら購入できる' do
      @order_address.prefecture_id = 47
      expect(@order_address).to be_valid
    end

    it 'phone_numberが10桁以上(11桁以下)の半角数値なら購入できる' do
      @order_address.phone_number = 1234567890
      expect(@order_address).to be_valid
    end

    it 'phone_numberが11桁以下(10桁以上)の半角数値なら購入できる' do
      @order_address.phone_number = 12345678901
      expect(@order_address).to be_valid
    end

    it 'buildingの値がなくても購入できる' do
      @order_address.building = nil
      expect(@order_address).to be_valid
    end

    it '存在する(登録済の)userなら購入できる' do
      expect(@order_address.user_id).to eq(@user.id)
      expect(@order_address).to be_valid
    end

    it '他のuserが出品したitemが存在すれば購入できる' do
      expect(@item.id).to eq(@order_address.item_id)
      expect(@item.user.id).to_not eq(@order_address.user_id)
      expect(@order_address).to be_valid
    end
  end

  context 'saveメソッドが成功するケース' do
    it 'Orderレコードが保存される' do
      expect { @order_address.save }.to change { Order.count }.by(1)
    end

    it 'Addressレコードが保存される' do
      @order_address.save
      expect { @order_address.save }.to change { Address.count }.by(1)
    end
  end

  context '商品購入ができないとき' do
    it 'postal_codeが空では購入できない' do
      @order_address.postal_code = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
    end

    it 'prefecture_idが空では購入できない' do
      @order_address.prefecture_id = 0
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
    end

    it 'cityが空では購入できない' do
      @order_address.city = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("City can't be blank")
    end

    it 'addressが空では購入できない' do
      @order_address.address = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Address can't be blank")
    end

    it 'phone_numberが空では購入できない' do
      @order_address.phone_number = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
    end

    it 'user_idが存在しないと購入できない' do
      @order_address.user_id = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("User can't be blank")
    end

    it 'item_idが存在しないと購入できない' do
      @order_address.item_id = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Item can't be blank")
    end

    it 'tokenが空では購入できない' do
      @order_address.token = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end

    it 'postal_codeが3桁-ハイフン4桁(の半角数値)でないと購入できない' do
      @order_address.postal_code = '1234-123'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
    end

    it 'postal_codeが(3桁ハイフン4桁の)半角数値でないと購入できない' do
      @order_address.postal_code = '１２３-４５６'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
    end

    it 'phone_numberが10桁未満の半角数値では購入できない' do
      @order_address.phone_number = 123456789
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number is too short (minimum is 10 characters)')
    end

    it 'phone_numberが11桁超過の半角数値では購入できない' do
      @order_address.phone_number = 123456789012
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number is too long (maximum is 11 characters)')
    end

    it 'phone_numberが半角数値でなければ購入できない' do
      @order_address.phone_number = '123456789０'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number is invalid. Input only number')
    end
  end

  context 'saveメソッドが失敗するケース' do
    it 'いずれかの属性が欠損するとOrderレコードが保存されない' do
      @order_address.user_id = ''
      expect { @order_address.save }.to change { Order.count }.by(0)
    end

    it 'order_idが発行されないと(Orderレコードの保存が成功しないと)Addressレコードが保存されない' do
      @order_address.user_id = ''
      expect { @order_address.save }.to change { Order.count }.by(0)
      expect { @order_address.save }.to change { Address.count }.by(0)
    end
  end
end
