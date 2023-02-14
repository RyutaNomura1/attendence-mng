require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "正常系の確認" do
    let!(:user){create(:user)}
    it "正しく投稿を登録できる" do
      post = Post.new(
      user_id: 1,
      title: "title of post",
      location: "location of post",
      body: "body of post",
      post_image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/images/test.jpg'))
      )
      
      expect(post).to be_valid
      post.save
      registed_post = Post.find(1);
      
      expect(registed_post.user_id).to eq(1)
      expect(registed_post.title).to eq("title of post")
      expect(registed_post.location).to eq("location of post")
      expect(registed_post.body).to eq("body of post")
    end
  end
  
  describe "バリデーションで無効になるパターン" do
    let!(:user){create(:user)}
    let(:post){build(:post)}
    context "存在性に関して" do 
      it "titleが空" do
        post.title = nil
        expect(post).to be_invalid
      end
  
      it "post_imageが空" do
        post.post_image = nil
        expect(post).to be_invalid
      end
    end
    
    context "文字数の制限に関して" do
      
      it "titleが30文字より大きい" do
        post.title = "a"* 31
        expect(post).to be_invalid
      end  
      
      it "bodyが300文字より大きい" do
        post.body = "a"* 301
        expect(post).to be_invalid
      end  
      
      it "locationが30文字より大きい" do
        post.location = "a"* 31
        expect(post).to be_invalid
      end  
    end
  end
end
