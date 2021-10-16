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
      @user.first_name = '漢字ひらカタ'
      expect(@user).to be_valid
    end

    it 'last_name_kanaが全角（カタカナ）であれば登録できる' do
      @user.last_name_kana = 'ゼンカク'
      expect(@user).to be_valid
    end
    it 'first_name_kanaが全角（カタカナ）であれば登録できる' do
      @user.first_name_kana = 'カタカナ'
      expect(@user).to be_valid
    end
  end

  context '新規登録ができないとき' do
    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'password_confirmationが空では登録できない' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'nicknameが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'last_nameが空では登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'first_nameが空では登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'last_name_kanaが空では登録できない' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end

    it 'first_name_kanaが空では登録できない' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

    it 'birth_dateが空では登録できない' do
      @user.birth_date = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth date can't be blank")
    end

    it 'emailが重複してる場合は登録できない' do
      @user.save
      user2 = FactoryBot.build(:user)
      user2.email = @user.email
      user2.valid?
      expect(user2.errors.full_messages).to include('Email has already been taken')
    end

    it 'emailに@が含まれない場合は登録できない' do
      @user.email = 'abcdefg.com'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'passwordが6文字未満では登録できない' do
      @user.password = 'a2345'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'passwordが半角英字を含まないと登録できない' do
      @user.password = '123456'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid')
    end

    it 'passwordが半角数字を含まないと登録できない' do
      @user.password = 'abcdef'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid')
    end

    it 'passwordとpassword_confirmationが一致しないと登録できない' do
      @user.password = 'a23456'
      @user.password_confirmation = 'b23456'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'last_nameが全角（漢字・ひらがな・カタカナ）でない場合は登録できない' do
      @user.last_name = 'ﾐｮｳｼﾞ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name is invalid')
    end

    it 'first_nameが全角（漢字・ひらがな・カタカナ）でない場合は登録できない' do
      @user.first_name = 'namae'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name is invalid')
    end

    it 'last_name_kanaが全角（カタカナ）でない場合は登録できない' do
      @user.last_name_kana = 'ﾐｮｳｼﾞ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana is invalid')
    end

    it 'first_name_kanaが全角（カタカナ）でない場合は登録できない' do
      @user.first_name_kana = 'なまえ'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana is invalid')
    end
  end
end
