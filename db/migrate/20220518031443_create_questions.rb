class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.text :question
      t.integer :marks
      t.text :model_answer
      t.text :keywords
      t.integer :max_length
      t.integer :min_length
      t.references :exam, null: false, foreign_key: true

      t.timestamps
    end
  end
end
