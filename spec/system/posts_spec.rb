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
        expect(page).to have_button "post_button"
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
          click_button "post_button"
          expect(current_path).to eq root_path
        end
        
        it "has success message" do
          click_button "post_button"
          expect(page).to have_content "titleを投稿しました"
        end
        
        it "creates new post" do
          expect {click_button "post_button"}.to change(Post, :count).by(1)
        end
        
        it "displays new post information" do
          #category_name =  find_by_id('post_category_ids_2')
          click_button "post_button"
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
        expect(page).to have_button "post_button"
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
          click_button "post_button"
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
    let!(:user){create(:user)}
    let!(:post){create(:post, user_id: user.id)}
    let!(:question){create(:question, user_id: user.id)}
    let!(:other_user){create(:user)}
    let!(:other_post){create(:post, user_id: other_user.id)}
    let!(:other_question){create(:question, user_id: other_user.id)}    
    
    before do
      register_category
      create_follow_relationships
      login(user)
    end
    
    describe "screen details" do
      # 画面左サイド
      it "displays Category lists" do
        big_categories = %w(国内旅行 アジア オセアニア 北アメリカ ヨーロッパ その他)
        big_categories.each do |big_category|
          expect(page).to have_content big_category
        end
      end
      # 画面中央
      it "displays my post" do
        expect(page).to have_content post.title
        expect(page).to have_content post.location
        expect(page).to have_content post.body
      end
      
      
      it "displays my question" do
        expect(page).to have_content question.question_title
        expect(page).to have_content question.question_body
      end
      
      it "displays number of answer of my question" do
        answer_count = question.answers.count
        expect(page).to have_content "#{answer_count}件の回答", count: 4
        create(:answer, user_id: user.id, question_id: question.id)
        expect(question.answers.count).to eq(answer_count + 1)
        visit root_path
        expect(page).to have_content "#{answer_count + 1}件の回答", count: 2
      end
      
      it "displays my question" do
        expect(page).to have_content question.question_title, count: 2
        expect(page).to have_content question.question_body
      end
      
      it "displays link to question show" do
        expect(page).to have_link href: question_path(question)
      end
      
      it "displays link to user show" do
        expect(page).to have_link href: user_path(user)
      end
      
      context "when there are more than 15 lists" do
        it "displays paginatiton bar" do
          15.times do
            create(:post, user_id: user.id)
          end
          expect(Post.count).to be > 15
          visit root_path
          expect(page).to have_css(".pagination")
        end
      end
      
      context "when there are less than 16 lists" do
        it "doesnt display paginatiton bar" do
          expect(Post.count).to be < 16
          expect(page).not_to have_css(".pagination")
        end
      end
      
      context "when user follows other_user" do
        
        it "displays other_user s post" do
          expect(page).to have_content other_post.title
          expect(page).to have_content other_post.location
          expect(page).to have_content other_post.body
        end
        
        it "displays other_user s question" do
          expect(page).to have_content other_question.question_title
          expect(page).to have_content other_question.question_body
        end
      end
      
      context "when user doesnt follows other_user" do
      before do
        Relationship.find_by(followed_id: other_user.id, follower_id: user.id).destroy
        visit root_path
      end
        it "doesnt display other_user s post" do
          expect(page).not_to have_content other_post.title
          expect(page).not_to have_content other_post.location
          expect(page).not_to have_content other_post.body
        end
        
        it "display other_user s question_body" do
          expect(page).not_to have_content other_question.question_body
        end        
      end
      
      # 画面右サイド
      it "displays user profile" do
        expect(page).to have_content user.current_location
        expect(page).to have_content user.travel_period
      end
      
      it "displays link to edit_user_path" do
        expect(page).to have_link "編集", href: edit_user_path(user)
      end
      
      it "displays count of followers" do
        follower_count = user.followers.count
        expect(page).to have_content "フォロワー#{follower_count}人"
        Relationship.find_by(followed_id: user.id, follower_id: other_user.id).destroy
        visit root_path
        expect(page).to have_content "フォロワー#{follower_count - 1}人"
      end
      
      it "displays count of followers" do
        followed_count = user.followings.count
        expect(page).to have_content "フォロー#{followed_count}人"
        Relationship.find_by(followed_id: other_user.id, follower_id: user.id).destroy
        visit root_path
        expect(page).to have_content "フォロー#{followed_count - 1}人"
      end
      
      it "displays most recent questions" do
        10.times do
          create(:question, user_id: user.id)
        end
        recent_questions = Question.order(created_at: :desc).limit(5)
        visit root_path
        recent_questions.each do |question|
          expect(page).to have_content question.question_title
        end
      end
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
