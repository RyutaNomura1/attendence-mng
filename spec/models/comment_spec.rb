require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "正常系の確認" do 
    let!(:user){create(:user)}
    let!(:post){create(:post)}
    it "正しく回答を登録できる" do
      comment = Comment.new(
        user_id: user.id,
        post_id: post.id,
        comment_body: "body of comment"
      )
      
      expect(comment).to be_valid
      comment.save
      registered_comment = Comment.find(1)
      
      expect(registered_comment.user_id).to eq(user.id)
      expect(registered_comment.post_id).to eq(post.id)
      expect(registered_comment.comment_body).to eq("body of comment")
    end
  end
  
  describe "バリデーションで無効になる場合" do
    let!(:user){create(:user)}
    let!(:post){create(:post)}
    before do 
      @comment = Comment.new(
        user_id: user.id,
        post_id: post.id,
        comment_body: "body of comment"
      )
    end
    it "comment_bodyが空" do
      @comment.comment_body = nil
      expect(@comment).to be_invalid
    end

    it "comment_bodyが300文字より大きい" do
      @comment.comment_body = "a"* 301
      expect(@comment).to be_invalid
    end
  end
end