require 'rails_helper'

RSpec.describe User, type: :model do
  describe "正常系の確認" do
    it "正しくユーザーを登録できる" do
    user = User.new(
        username: "山田太郎",
        email: "taro@mail.com",
        password: "password",
        password_confirmation: "password",
        profile: "profile of user",
        travel_period: "１年",
        current_location: "日本"
      )
      
      expect(user).to be_valid
      user.save
      registered_user = User.find(1)
      
      expect(registered_user.username).to eq("山田太郎")
      expect(registered_user.email).to eq("taro@mail.com")
      expect(registered_user.profile).to eq("profile of user")
      expect(registered_user.travel_period).to eq("１年")
      expect(registered_user.current_location).to eq("日本")
    end
  end
  
  describe "バリデーションで無効になるパターン" do
    let!(:user){build(:user)} 
    context "存在性に関して" do
      it "usernameが空" do
        user.username = nil
        expect(user).to be_invalid
      end
      
      it "emailが空" do
        user.email = nil
        expect(user).to be_invalid
      end
      
      it "passwordが空" do
        user.password = nil
        expect(user).to be_invalid
      end
    end
    
    context "文字数の制限に関して" do 
      let!(:user){build(:user)}
      it "usernameが30文字より大きい" do
        user.username = "a"* 31
        expect(user).to be_invalid
      end  
      
      it "emailが255文字より大きい" do
        user.email = "a"* 256
        expect(user).to be_invalid
      end  
      
      it "passwordが6文字より小さい" do
        user.password = "a"* 5
        user.password_confirmation = "a"* 5
        expect(user).to be_invalid
      end  
      
      it "profileが200文字より大きい" do
        user.profile = "a"* 201
        expect(user).to be_invalid
      end
      
      it "travel_periodが30文字より大きい" do
        user.travel_period = "a"* 31
        expect(user).to be_invalid
      end  
      
      it "current_locationが30文字より大きい" do
        user.current_location = "a"* 31
        expect(user).to be_invalid
      end
    end
  
    context "その他、emailに関して" do

      it "emailが重複する" do
        
        user = User.create(
          username: "山田太郎",
          email: "user@example.com",
          password: "a"* 6,
          password_confirmation: "a"* 6
        )
        other_user = User.new(
          username: "鈴木一郎",
          email: "user@example.com",
          password: "b"* 6,
          password_confirmation: "b"* 6
        )
        expect(other_user).to be_invalid      
        
      end
    end  
      
    context "その他、パスワードに関して" do  
      let!(:user){build(:user)}
      it "passwordとpassword_confirmationが異なる" do 
        user.password_confirmation = "b"
        expect(user).to be_invalid
      end
    end
  end
end
