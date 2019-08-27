class DetailExam < ApplicationRecord
  belongs_to :trainee_exam
  belongs_to :question
  has_many :detail_exam_answers
  has_many :answers, through: :detail_exam_answers

  accepts_nested_attributes_for :detail_exam_answers,
    allow_destroy: true

  delegate :checked, to: :detail_exam_answers, prefix: :answer
end
