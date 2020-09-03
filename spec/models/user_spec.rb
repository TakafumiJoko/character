require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Userモデルのバリデーション' do
    before do
      @user = FactoryBot.build(:user) 
    end
    
    it 'before文のチェック' do
      expect(@user.valid?).to eq(true)
    end
    
    describe 'name属性' do
      it '存在性' do
        @user.name = ""
        expect(@user.valid?).to eq(false)
      end
      
      it '長さ（6文字以上か）' do
        @user.name = "a" * 5
        expect(@user.valid?).to eq(false)
        @user.name = "a" * 6
        expect(@user.valid?).to eq(true)
      end
      
      it '長さ（55文字以下か）' do
        @user.name = "a" * 55
        expect(@user.valid?).to eq(true)        
        @user.name = "a" * 56
        expect(@user.valid?).to eq(false)
      end
    end
    
    describe 'email属性' do
      it '存在性' do
        @user.email = ""
        expect(@user.valid?).to eq(false)
      end 
      
      it '長さ(72文字以下か)' do
        @user.email = "a" * 60 + "@example.com"
        expect(@user.valid?).to eq(true)
        @user.email = "a" * 61 + "@example.com"
        expect(@user.valid?).to eq(false)
      end
      
      it 'フォーマット' do
        @user.email = "USER@foo.COM"
        expect(@user.valid?).to eq(true)
        @user.email = "THE_US-ER@foo.bar.org"
        expect(@user.valid?).to eq(true)
        @user.email = "first.last@foo.jp"
        expect(@user.valid?).to eq(true)
        @user.email = "alice+bob@baz.cn"
        expect(@user.valid?).to eq(true)
      end
      
      it '小文字かどうか' do
        @user.email = "USER@EXAMPLE.COM"
        lower_case_email = @user.email.downcase
        @user.save!
        expect(@user.reload.email).to eq(lower_case_email)
      end
      
      it '一意性' do
        duplicate_user = @user.dup
        @user.save!
        expect(duplicate_user.save).to eq(false)
      end
    end
    
    describe 'password属性' do
      it 'password属性の存在性' do
        @user.password = @user.password_confirmation = ""
        expect(@user.valid?).to eq(false)
      end   
      
      it '長さ(6文字未満)' do
        @user.password = @user.password_confirmation = "a" * 5 
        expect(@user.valid?).to eq(false)
      end
      
      it 'has_secure_passwordを実装したか' do
        @user.password = "password"
        @user.password_confirmation = "unmatch"
        expect(@user.valid?).to eq(false)
      end
    end
    
  
    
    
    it 'password_confirmation属性の存在性' do
      @user.password = ""
      @user.password_confirmation = ""
      expect(@user.valid?).to eq(false)
    end   
  end
end
