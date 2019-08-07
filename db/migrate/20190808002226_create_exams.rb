class CreateExams < ActiveRecord::Migration[5.2]
  def change
    create_table :exams do |t|
      t.references :subject, foreign_key: true
      t.string :name
      t.time :time_limit
      t.integer :pass_score
      t.integer :number_question

      t.timestamps
    end
  end
end
