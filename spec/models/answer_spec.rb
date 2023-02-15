require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe "正常系の確認" do 
    let!(:user){create(:user)}
    let!(:question){create(:question)}
    it "正しく回答を登録できる" do
      answer = Answer.new(
        user_id: user.id,
        question_id: question.id,
        answer_body: "body of answer"
      )
      
      expect(answer).to be_valid
      answer.save
      registered_answer = Answer.find(1)
      
      expect(registered_answer.user_id).to eq(user.id)
      expect(registered_answer.question_id).to eq(question.id)
      expect(registered_answer.answer_body).to eq("body of answer")
    end
  end
  
  describe "バリデーションで無効になる場合" do
    let!(:user){create(:user)}
    let!(:question){create(:question)}
    before do 
      @answer = Answer.new(
        user_id: user.id,
        question_id: question.id,
        answer_body: "body of answer"
      )
    end
    it "answer_bodyが空" do
      @answer.answer_body = nil
      expect(@answer).to be_invalid
    end

    it "answer_bodyが300文字より大きい" do
      @answer.answer_body = "a"* 301
      expect(@answer).to be_invalid
    end
  end
end
