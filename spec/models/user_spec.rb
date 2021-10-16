require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  context '新規登録ができるとき' do
    it '8つのカラム全てに正しい値が存在すれば登録できる' do
      expect(@user).to be_valid
    end

    it 'emailが一意であれば登録できる' do
      @user.email = 'test@aaa'
      expect(User.where(email: 'test@aaa').count).to eq(0)
      expect(@user).to be_valid
    end

    it 'emailに@があれば登録できる' do
      @user.email = 'a@a'
      expect(@user).to be_valid
    end

    it 'passwordが6文字以上であれば登録できる' do
      @user.password = 'a23456'
      @user.password_confirmation = @user.password
      expect(@user).to be_valid
    end

    it 'passwordが半角英数字混合であれば登録できる' do
      @user.password = 'test01'
      @user.password_confirmation = @user.password
      expect(@user).to be_valid
    end

    it 'passwordとpassword_confirmationが一致すれば登録できる' do
      @user.password = 'test01'
      @user.password_confirmation = 'test01'
      expect(@user).to be_valid
    end

    it 'last_nameが全角（漢字・ひらがな・カタカナ）であれば登録できる' do
      @user.last_name = '漢字ひらカタ'
      expect(@user).to be_valid
    end

    it 'first_nameが全角（漢字・ひらがな・カタカナ）であれば登録できる' do
      @user.first_name = "漢字ひらカタ"
      expect(@user).to be_valid
    end

    it 'last_name_kanaが全角（カタカナ）であれば登録できる' do
      @user.last_name_kana = "ゼンカク"
      expect(@user).to be_valid
    end
    it 'first_name_kanaが全角（カタカナ）であれば登録できる' do
      @user.first_name_kana = "カタカナ"
      expect(@user).to be_valid
    end
  end

end
