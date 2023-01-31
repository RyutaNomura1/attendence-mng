class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.references :user, foreign_key: true
      t.string :question_title
      t.text :question_body

      t.timestamps
    end
  end
end
