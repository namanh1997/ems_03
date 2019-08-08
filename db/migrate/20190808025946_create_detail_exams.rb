class CreateDetailExams < ActiveRecord::Migration[5.2]
  def change
    create_table :detail_exams do |t|
      t.references :trainee_exam, foreign_key: true
      t.references :question, foreign_key: true
      t.integer :answer
      t.boolean :is_result

      t.timestamps
    end
  end
end
