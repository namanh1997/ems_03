class CreateTraineeExams < ActiveRecord::Migration[5.2]
  def change
    create_table :trainee_exams do |t|
      t.references :exam, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :total_score
      t.time :complete_time
      t.boolean :is_passed

      t.timestamps
    end
  end
end
