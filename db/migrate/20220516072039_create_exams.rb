class CreateExams < ActiveRecord::Migration[6.1]
  def change
    create_table :exams do |t|
      t.string :subject
      t.text :instructions
      t.integer :pass_mark
      t.integer :total_marks
      t.datetime :start_time
      t.datetime :end_time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
