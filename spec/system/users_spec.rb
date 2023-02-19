require 'rails_helper'

RSpec.describe "Users", js: true,type: :system do
  before do
    driven_by(:rack_test)
  end
  
  let!(:user){create(:user)}
  let!(:other_user){create(:user)}
  let!(:relationship1){create(:relationship1)}
  let!(:relationship2){create(:relationship2)}
  let!(:post){create(:post)}
  let!(:question){create(:question)}
  big_categories = [:japan, :asia, :oceania, :north_america, :europe, :other ]
  big_categories.each do |big_category|
    let!(big_category){create(big_category)}
  end

  describe "Get users#new" do
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
  
  describe "Get users#edit" do
    let!(:user){create(:user)}
    before do
      login(user)
      visit edit_user_path(user)
    end
    
    describe "screen details" do
      it "displays link to users edit_user_path" do 
        expect(page).to have_link "基本情報", href: edit_user_path(user)
      end
      
      it "displays link to users edit_user_path" do 
        expect(page).to have_link "パスワード設定", href: edit_user_password_path(user)
      end
      
      it "displays button to user_path(patch) " do
        expect(page).to have_button "プロフィールを更新"
      end
      
      # it "displays user profiles" do
      #   expect(page).to have_content user.username
      #   expect(page).to have_content user.email
      #   expect(page).to have_content user.profile
      #   expect(page).to have_content user.current_location
      #   expect(page).to have_content user.travel_period
      # end
      
    end
    
    describe "screen oparation" do 
    
      context "when input contents are valid" do
        before do 
          fill_in "名前", with: "new_username"
          fill_in "メールアドレス", with: "new@mail.com"
          fill_in "自己紹介", with: "new_profile"
          fill_in "旅歴", with: "new_travel_period"
          fill_in "現在地", with: "new_current_location"
          click_button "プロフィールを更新"
        end
        
        it "update user information" do
          expect(user.reload.username).to eq "new_username" 
          expect(user.reload.email).to eq "new@mail.com" 
          expect(user.reload.profile).to eq "new_profile" 
          expect(user.reload.travel_period).to eq "new_travel_period" 
          expect(user.reload.current_location).to eq "new_current_location" 
        end
        
        it "redirect to user_path" do
          expect(current_path).to eq user_path(user)
        end
        
        it "has success message" do
          expect(page).to have_content("#{user.reload.username}さんのプロフィールを更新しました")
        end
        
      end
      
      context "when input contents are invalid" do
        before do 
          fill_in "名前", with: nil
          fill_in "メールアドレス", with: nil
          fill_in "自己紹介", with: "new_profile"
          fill_in "旅歴", with: "new_travel_period"
          fill_in "現在地", with: "new_current_location"
          click_button "プロフィールを更新"
        end
        
        it "render the the users/edit" do
          expect(current_path).to eq edit_user_path(user)
        end
        
        it "has 3 errors" do
          expect(page).to have_content("3件のエラー")
          expect(page).to have_content("名前を入力してください")
          expect(page).to have_content("メールアドレスを入力してください")
          expect(page).to have_content("メールアドレスは不正な値です")
        end
      end
    end
    
    
  end
  
  describe "Get users#edit_password" do
    let!(:user){create(:user)}
    before do
      login(user)
      visit edit_user_password_path(user)
    end
    
    describe "screen details" do
      
      it "displays link to users edit_user_path" do 
        expect(page).to have_link "基本情報", href: edit_user_path(user)
      end
      
      it "displays link to users edit_user_path" do 
        expect(page).to have_link "パスワード設定", href: edit_user_password_path(user)
      end
      
      it "displays button to user_path(patch) " do
        expect(page).to have_button "パスワードを変更"
      end
    end
    
    
    describe "screen oparation" do
      
      context "when input contents are valid" do
        before do
          fill_in "パスワード", with: "new_password"
          fill_in "パスワード確認", with: "new_password"
          click_button "パスワードを変更"
        end
        
        it "update user password_digest" do
          expect(user.password_digest).not_to eq(user.reload.password_digest)
        end
        
        it "redirect to user_path" do
          expect(current_path).to eq user_path(user)
        end
        
        it "has success message" do
          expect(page).to have_content("#{user.reload.username}さんのパスワードを変更しました")
        end
      end
      
      # context "when input contents are invalid" do
      #   before do
      #     fill_in "パスワード", with: nil
      #     fill_in "パスワード確認", with: nil
      #     click_button "パスワードを変更"
      #   end
        
      #   it "redirect to user" do 
      #     expect(current_path).to eq user_edit_password_path(user)
      #   end
        
      #   it "has danger message" do
      #     expect(page).to have_content("有効な組み合わせではありません")
      #   end
        
      # end
    end
  end


  describe "Get users#show" do
    describe "screen details" do
      context "when the displayed page is own page " do
        before do
          login(user)
          visit user_path(user)
        end
        it "displays content of user profile" do
          expect(page).to have_content user.username
          expect(page).to have_content user.profile
          expect(page).to have_content user.travel_period
          expect(page).to have_content user.current_location
        end
        
        it "displays usr profile image" do 
          expect(page).to have_css '#rspec_user_path_profile_image'
        end
        
        it "displays content of follow relationship" do
          expect(page).to have_content "フォロー#{other_user.followings.count}人"
          expect(page).to have_content "フォロワー#{other_user.followers.count}人"
        end
        
        it "displays link to edit_user_path" do
          expect(page).to have_link "プロフィールを編集", href: edit_user_path(user)
        end

        it "dosent display button to user_relationships(delete)" do
          expect(page).to have_no_button "rspec_user_path_follow_button"
        end
      end
      
      context "when the displayed page is someones page " do  
        before do
          login(user)
          visit user_path(other_user)
        end
        
        it "displays content of other_user profile" do
          visit user_path(other_user)
          expect(page).to have_content other_user.username
          expect(page).to have_content other_user.profile
          expect(page).to have_content other_user.travel_period
          expect(page).to have_content other_user.current_location
        end
        
        it "displays content of follow relationship" do
          expect(page).to have_content "フォロー#{user.followings.count}人"
          expect(page).to have_content "フォロワー#{user.followers.count}人"
        end
        
        it "doesnt display link to edit_user_path" do
          expect(page).to have_no_link "プロフィールを編集"
        end
        
        it "displays unfollow button " do
          expect(page).to have_button "rspec_user_path_unfollow_button"
        end
        
        it "doesnt display follow button " do
          expect(page).to have_no_button "rspec_user_path_follow_button"
        end
        
        context "when button to user_relationships is clicked" do 
          
          # ボタンをクリックするとリンクが変わること
          # it "doesnt display button to user_relationships(delete)" do
          #   click_button 'rspec_user_path_unfollow_button'
          #   expect(page).to have_no_button "rspec_user_path_unfollow_button"
          # end
          
          # it "displays button to user_relationships(post)" do
          #   click_button 'rspec_user_path_unfollow_button'
          #   expect(page).to have_button "rspec_user_path_follow_button"
          # end
          
          # it "delete following relationships" do
          #   expect {click_button "rspec_user_path_unfollow_button"}.to change( other_user.followers, :count).by(-1)
          # end
          
        end
      end
    end
  end
  
  describe "before action" do
    context "when try to action without login" do
    end
    
    context "when different user try to action" do
      before do
        login user
      end
      
      context "when user try to edit different user" do
        before do 
          visit edit_user_path(other_user)
        end
        
        it "redirect to root path" do
          expect(current_path).to eq root_path
        end
        
        it "has danger message" do
          expect(page).to have_content ("その機能はユーザー本人しか利用できません") 
        end
      end
      
      context "when user try to edit different user password" do
        before do 
          visit edit_user_password_path(other_user)
        end
        it "redirect to root path" do
          expect(current_path).to eq root_path
        end
        
        it "has danger message" do
          expect(page).to have_content ("その機能はユーザー本人しか利用できません") 
        end
        
      end
      
      
    end
    
  end
end

  