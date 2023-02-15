require 'rails_helper'

RSpec.describe Helpful, type: :model do
  describe "正常系の確認" do
    let!(:user){create(:user)}
    let!(:question){create(:question)}
    let!(:answer){create(:answer)}
    it "正しくhelpfulを登録できる" do
      helpful = Helpful.new(
        user_id: user.id,
        answer_id: answer.id
      )
      
      expect(helpful).to be_valid
      helpful.save
      registered_helpful = Helpful.find(1)

      expect(registered_helpful.user_id). to eq(user.id)      
      expect(registered_helpful.user_id). to eq(answer.id)      
    end
  end
  
  
  
  describe "バリデーションで無効になる場合" do 
    let!(:user){create(:user)}
    let!(:question){create(:question)}
    let!(:answer){create(:answer)}
    it "ユーザーは1つの回答に対して1度のみhelpfulできる" do
      helpful = Helpful.create(
        user_id: user.id,
        answer_id: answer.id
      )
      other_helpful = Helpful.new(
        user_id: user.id,
        answer_id: answer.id
      )
      
      expect(other_helpful).to be_invalid
    end
  end
end
