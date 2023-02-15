require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe "正常系の確認" do
    let!(:user){create(:user)}
    let!(:post){create(:post)}

    it "正しくfavoriteを登録できる" do
      favorite = Favorite.new(
        user_id: user.id,
        post_id: post.id
      )
      
      expect(favorite).to be_valid
      favorite.save
      registered_favorite = Favorite.find(1)

      expect(registered_favorite.user_id). to eq(user.id)      
      expect(registered_favorite.user_id). to eq(post.id)      
    end
  end
  
  
  
  describe "バリデーションで無効になる場合" do 
    let!(:user){create(:user)}
    let!(:post){create(:post)}
    it "ユーザーは1つの回答に対して1度のみfavoriteできる" do
      favorite = Favorite.create(
        user_id: user.id,
        post_id: post.id
      )
      other_favorite = Favorite.new(
        user_id: user.id,
        post_id: post.id
      )
      expect(other_favorite).to be_invalid
    end
  end
end