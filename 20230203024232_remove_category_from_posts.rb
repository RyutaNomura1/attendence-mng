class RemoveCategoryFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :category, :integer
  end
end
