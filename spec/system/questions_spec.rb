require 'rails_helper'

RSpec.describe "Questions", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "Get questions#new" do
    let!(:user){create(:user)}
    
    before do
      register_category
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
    let!(:user){create(:user)}
    let!(:other_user){create(:user)}
    let!(:other_user2){create(:user)}
    let!(:question){create(:question, user_id: other_user.id)}
    let!(:answer){create(:answer, user_id: other_user2.id, question_id: question.id)}
    before do
      register_category
      login(user)
      visit question_path(question)
    end    
    
    describe "screen datails" do
      it "displays contents of question" do
        expect(page).to have_content question.user.username
        expect(page).to have_content question.question_title
        expect(page).to have_content question.question_body
      end
      
      it "displays number of answers" do
        expect(page).to have_content "#{question.answers.count}件の回答"
      end
      
      it "displays form to create new answer" do
        expect(page).to have_content user.username
        expect(page).to have_content "質問に回答する"
        expect(page).to have_button "回答を投稿"
      end
      
      it "displays contents of answer" do
        expect(page).to have_content answer.user.username
        expect(page).to have_content answer.answer_body
      end
      
      it "displays link to create helpful" do
        expect(page).to have_link "役に立つ", href: create_helpful_path(answer)
      end
    end
    
    describe "screen oparations" do
      context "when user try to create new valid answer", js: true do
        before do
        fill_in "answer_answer_body", with: "new_answer"
        end
        
        
        it "displays contents of new answer" do
          click_button "回答を投稿"
          expect(page).to have_content "new_answer"
        end
        
        it "displays link to delete new answer" do
          click_button "回答を投稿"
          expect(page).to have_selector ".fa-trash-alt"
        end
        
        it "creates new answer" do
           expect {click_button "回答を投稿"}.to change(Answer, :count).by(1)
        end
        
        it "changes count of answer in the page" do
          answer_count = question.answers.count
          click_button "回答を投稿"
          expect(page).to have_content "#{answer_count + 1}件の回答"
        end
        it "creates new answer" do
           expect {click_button "回答を投稿"}.to change(Answer, :count).by(1)
        end
      end
      
      context "when user try to create new invalid answer" do
        context "when textarea is empty"
        before do
        fill_in "answer_answer_body", with: ""
        end
        
        it "doesnt creates new answer" do
           expect {click_button "回答を投稿"}.to change(Answer, :count).by(0)
        end
        
        it "doesnt changes count of answer in the page" do
          answer_count = question.answers.count
          click_button "回答を投稿"
          expect(page).to have_content "#{answer_count + 0}件の回答"
        end
        
        context "when textarea contents are more than 300words"
        before do
        fill_in "answer_answer_body", with: "a"*301
        end
        
        
        it "creates new answer" do
           expect {click_button "回答を投稿"}.to change(Answer, :count).by(0)
        end
        
        it "changes count of answer in the page" do
          answer_count = question.answers.count
          click_button "回答を投稿"
          expect(page).to have_content "#{answer_count + 0}件の回答"
        end
      end
    end
  end
end
