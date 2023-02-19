require 'rails_helper'

RSpec.describe "Sessions", type: :system do
  let!(:user){create(:user)}
  # root_path表示用の定義
  let!(:question){create(:question)}
  big_categories = [:japan, :asia, :oceania, :north_america, :europe, :other ]
  big_categories.each do |big_category|
    let!(big_category){create(big_category)}
  end

  before do
    driven_by(:rack_test)
  end
  
  before do
    visit login_path
  end
  describe "GET sessions#new" do 
    context "when input contents are valid" do 
      before do
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: "password"
        click_button "rspec_login_button"
      end
      
      it "redirect to root_path" do
        expect(current_path).to eq root_path
      end
      
      it "has success message" do
        expect(page).to have_content "#{user.username}さん、ようこそSharevelへ"
      end
    end
    
    context "when input contents are empty" do
      before do
        fill_in "メールアドレス", with: ""
        fill_in "パスワード", with: ""
        click_button "rspec_login_button"
      end      
      
      it "render the sessions/new" do 
        expect(current_path).to eq login_path
      end
      
      it "has danger message" do
        expect(page).to have_content("有効な組み合わせではありません")
      end
    end
    
    context "when email is invalid" do
      before do
        fill_in "メールアドレス", with: "invalid@mail.com"
        fill_in "パスワード", with: "password"
        click_button "rspec_login_button"
      end      
      
      it "render the sessions/new" do 
        expect(current_path).to eq login_path
      end
      
      it "has danger message" do
        expect(page).to have_content("有効な組み合わせではありません")
      end
    end
    
    context "when password is invalid" do
      before do
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: "invalid"
        click_button "rspec_login_button"
      end      
      
      it "render the sessions/new" do 
        expect(current_path).to eq login_path
      end
      
      it "has danger message" do
        expect(page).to have_content("有効な組み合わせではありません")
      end
    end
    
    describe "screen details" do
      it "displays link to login_path" do
        expect(page).to have_link "初めての方はこちら", href: new_user_path 
      end
    end  
    
  end
end
