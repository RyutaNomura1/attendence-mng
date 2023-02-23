require 'rails_helper'

RSpec.describe "Questions", type: :system do
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
  
  describe "Get questions#new" do
    before do
      login(user)
      visit new_question_path
    end    
    
    describe "screen datails" do
      it "displays button for question_path(post)" do
        expect(page).to have_button "rspec_create_question_button"
      end
    end
    
    describe "screen oparations" do
      before do
        fill_in "タイトル", with: "title of question2"
        fill_in "内容", with: "body of question2"
      end
      
             
      it "redirect to root_path" do
        click_button "rspec_create_question_button"
        expect(current_path).to eq root_path
      end
      
      it "has success message" do
        click_button "rspec_create_question_button"
        expect(page).to have_content "質問「title of question2」を投稿しました"
      end
      
      it "creates new question" do
        expect {click_button "rspec_create_question_button"}.to change(Question, :count).by(1)
      end
      
      it "displays new post information" do
        click_button "rspec_create_question_button"
        expect(page).to have_content "title of question2"
        expect(page).to have_content "body of question2"
        
      end
    end
  end
  
  describe "Get questions#show" do
    before do
      login(user)
      visit new_question_path
    end    
    
    describe "screen datails" do
      
    end
    
    describe "screen oparations" do
      
    end
    
    before do
      login user
      visit root_path
    end
    
    describe "screen datails" do
      
    end
    
    describe "screen oparations" do

    end
    
  end
end
