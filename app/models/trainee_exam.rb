class TraineeExam < ApplicationRecord
  TRAINEE_EXAM_PARAMS = [:complete_time, :exam_id,
    detail_exams_attributes: [:question_id,
    detail_exam_answers_attributes: [:checked, :answer_id, :id]]].freeze
  belongs_to :exam
  belongs_to :user
  has_many :detail_exams, dependent: :destroy

  scope :sort_by_subject_and_name,
    ->{includes({exam: :subject}, :user).order(created_at: :desc)}

  delegate :subject_name, :name, to: :exam, prefix: true
  delegate :name, to: :user, prefix: true

  accepts_nested_attributes_for :detail_exams,
    allow_destroy: true
end
