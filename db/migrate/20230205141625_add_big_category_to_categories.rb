class AddBigCategoryToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :big_category, :string, null: false
  end
end
