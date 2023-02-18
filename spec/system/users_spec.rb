require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    driven_by(:rack_test)
  end
  
  let!(:user){create(:user)}
  let!(:post){create(:post)}
  let!(:question){create(:question)}
  big_categories = [:japan, :asia, :oceania, :north_america, :europe, :other ]
  big_categories.each do |big_category|
    let!(big_category){create(big_category)}
  end

  describe "GET users#new" do
   before do
     visit new_user_path
   end
   
    context "when input contents are valid " do 
      before do
        fill_in "名前", with: "山田太郎"
        fill_in "メールアドレス", with: "example@mail.com"
        fill_in "パスワード",with: "password"
        fill_in "パスワード確認",with: "password"
      end
      
      it "create new user" do 
        expect {click_button "rspec_new_user_button"}.to change(User, :count).by(1)
      end
      
      it "redirect to root_path" do
        click_button "rspec_new_user_button"
        expect(current_path).to eq root_path
      end
    end
  
    
    context "when input contents are empty" do
      before do 
        fill_in "名前", with: ""
        fill_in "メールアドレス", with: ""
        fill_in "パスワード",with: ""
        fill_in "パスワード確認",with: ""
      end
      
      it "has eroor messages" do
        click_button "rspec_new_user_button"
        expect(page).to have_content "4件のエラー"
        expect(page).to have_content "パスワードを入力してください"
        expect(page).to have_content "名前を入力してください"
        expect(page).to have_content "メールアドレスを入力してください"
        expect(page).to have_content "メールアドレスは不正な値です"
      end
      
      it "doesnt create new user" do
        expect {click_button "rspec_new_user_button"}.to change(User, :count).by(0)
      end
    end
    
    describe "screen details" do
      it "displays link to login path" do
        expect(page).to have_link "既に登録済みの方はこちら", href: login_path 
      end
    end
  end

  describe "users#show画面" do
    before do
      login(user)
      visit user_path
    end
  end
  
  
end
  