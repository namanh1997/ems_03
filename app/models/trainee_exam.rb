class TraineeExam < ApplicationRecord
  belongs_to :exam
  belongs_to :user
  has_many :detail_exams

  validates :total_score, presence: true
  validates_inclusion_of :is_passed,
    in: [true, false, "true", "false", 1, 0]
  validates :complete_time, presence: true
end
