require 'rails_helper'

RSpec.describe Question, type: :model do
  describe "正常系の確認" do
    let!(:user){create(:user)}
    it "正しく質問を登録できる" do
      question = Question.new(
      user_id: user.id,
      question_title: "title of question",
      question_body: "body of question",
      )
      
      expect(question).to be_valid
      question.save
      registed_question = Question.find(1);
      
      expect(registed_question.user_id).to eq(1)
      expect(registed_question.question_title).to eq("title of question")
      expect(registed_question.question_body).to eq("body of question")
    end
  end
  describe "バリデーションで無効になるパターン" do
    let!(:user){create(:user)}
    let(:question){build(:question)}
    context "存在性に関して" do 
      it "question_titleが空" do
       question.question_title = nil
        expect(question).to be_invalid
      end
  
      it "question_bodyが空" do
        question.question_body = nil
        expect(question).to be_invalid
      end
    end
    
    context "文字数の制限に関して" do
      
      it "question_titleが30文字より大きい" do
        question.question_title = "a"* 31
        expect(question).to be_invalid
      end  
      
      it "bodyが300文字より大きい" do
        question.question_body = "a"* 301
        expect(question).to be_invalid
      end  
    end
  end
end

