class DetailExam < ApplicationRecord
  belongs_to :trainee_exam
  belongs_to :question
  has_many :detail_exam_answers, dependent: :destroy
  has_many :answers, through: :detail_exam_answers

  accepts_nested_attributes_for :detail_exam_answers,
    allow_destroy: true
end
