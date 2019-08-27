class TraineeExam < ApplicationRecord
  belongs_to :exam
  belongs_to :user
  has_many :detail_exams

  scope :sort_by_subject_and_name,
    ->{includes({exam: :subject}, :user).order(created_at: :desc)}

  delegate :subject_name, :name, to: :exam, prefix: true
  delegate :name, to: :user, prefix: true

  validates_inclusion_of :is_passed,
    in: [true, false, "true", "false", 1, 0]
  validates :complete_time, presence: true
end
