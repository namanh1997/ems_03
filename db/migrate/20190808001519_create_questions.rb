class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.references :subject, foreign_key: true
      t.integer :supervisor_id
      t.string :content
      t.integer :type, default: 1
      t.integer :level, default: 0

      t.timestamps
    end
  end
end
