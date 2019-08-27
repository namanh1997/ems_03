class CreateDetailExamAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :detail_exam_answers do |t|
      t.references :detail_exam, foreign_key: true
      t.references :answer, foreign_key: true

      t.timestamps
    end
  end
end
