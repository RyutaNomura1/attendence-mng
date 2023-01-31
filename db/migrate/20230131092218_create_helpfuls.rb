class CreateHelpfuls < ActiveRecord::Migration[5.2]
  def change
    create_table :helpfuls do |t|
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.timestamps

    end
  end
end
