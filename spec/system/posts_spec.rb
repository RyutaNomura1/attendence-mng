require 'rails_helper'

RSpec.describe "Posts", type: :system do
  before do
    driven_by(:rack_test)
  end


  describe "Get posts#new" do 
    let!(:user){create(:user)}
    before do
      register_category
      login(user)
      visit new_post_path
    end
    describe "screen details" do
      
      it "displays button for post_path(post)" do 
        expect(page).to have_button "rspec_post_button"
      end
    end
    
    describe "screen oparation" do
      context "when input contents are valid" do
        let!(:user){create(:user)}
        before do
          register_category
          fill_in "タイトル", with: "title"
          fill_in "場所", with: "location"
          fill_in "内容", with: "body"
          # check "post_category_ids_2"
          attach_file "post_post_image", "#{Rails.root}/spec/fixtures/images/test.jpg"
        end
        
        it "redirect to root_path" do
          click_button "rspec_post_button"
          expect(current_path).to eq root_path
        end
        
        it "has success message" do
          click_button "rspec_post_button"
          expect(page).to have_content "titleを投稿しました"
        end
        
        it "creates new post" do
          expect {click_button "rspec_post_button"}.to change(Post, :count).by(1)
        end
        
        it "displays new post information" do
          #category_name =  find_by_id('post_category_ids_2')
          click_button "rspec_post_button"
          expect(page).to have_content "title"
          expect(page).to have_content "location"
          expect(page).to have_content "body"
          # expect(page).to have_content "東京"
        end
      end
      
      
    end
  end
  
  describe "Get posts#edit" do 
    let!(:user){create(:user)}
    let!(:post){create(:post)}
    before do
      register_category
      login(user)
      visit edit_post_path(post)
    end
    
    describe "screen details" do
      
      it "displays button for post_path(patch)" do 
        expect(page).to have_button "rspec_post_button"
      end
    end
    
    describe "screen oparation" do
      context "when input contents are valid" do
        before do
          fill_in "タイトル", with: "new_title"
          fill_in "場所", with: "new_location"
          fill_in "内容", with: "new_body"
          find("#post_category_ids_3").click
          attach_file "post_post_image", "#{Rails.root}/spec/fixtures/images/test2.jpg"
          click_button "rspec_post_button"
        end
        
        it "redirects to root_path" do
          expect(current_path).to eq root_path
        end
        
        it "has success message" do
          expect(page).to have_content "#{post.reload.title}を更新しました"
        end
        
        it "updates the post" do
          expect(post.reload.title).to eq "new_title"
          expect(post.reload.location).to eq "new_location"
          expect(post.reload.body).to eq "new_body"
        end 
        
        it "displays new post information" do
          expect(page).to have_content "new_title"
          expect(page).to have_content "new_location"
          expect(page).to have_content "new_body"
        end
      end
    end
  end
  
  describe "Get posts#index" do
    describe "screen details" do
      
    end

    describe "screen oparations" do
      
    end
    
    
  end

  describe "before action" do
    context "when try to action without login" do
      context "when try to see posts without login" do
        before do
          visit root_path
        end
        it "redirects to new user path" do
          expect(current_path).to eq new_user_path
        end
        
        it "has danger message" do
          expect(page).to have_content "新規登録、またはログインをしてください"
        end
      end
      
      context "when try to create new post without login" do
        before do
          visit new_post_path
        end
        it "redirects to new user path" do
          expect(current_path).to eq new_user_path
        end
        
        it "has danger message" do
          expect(page).to have_content "新規登録、またはログインをしてください"
        end
      end
      
      context "when try to edit post without login" do
        let!(:user){create(:user)}
        let!(:post){create(:post)}
        before do
          visit edit_post_path(post)
        end
        it "redirects to new user path" do
          expect(current_path).to eq new_user_path
        end
        
        it "has danger message" do
          expect(page).to have_content "新規登録、またはログインをしてください"
        end
      end
    end
    
    context "when incorrect user try to action" do
      
      let!(:user){create(:user)}
      let!(:other_user){create(:user)}
      let!(:post){create(:post)}
      before do
        register_category
        login other_user
      end
      context "when user try to edit other users post" do
        
        before do 
          visit edit_post_path(post)
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
