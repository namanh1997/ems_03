class DetailExam < ApplicationRecord
  belongs_to :trainee_exam
  belongs_to :question
  has_many :detail_exam_answers
  has_many :answers, through: :detail_exam_answers
end
