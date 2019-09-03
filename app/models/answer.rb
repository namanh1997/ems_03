class Answer < ApplicationRecord
  belongs_to :question
  has_many :detail_exam_answers
  has_many :detail_exams, through: :detail_exam_answers

  validates :content, presence: true
  validates_inclusion_of :correct,
    in: [true, false, "true", "false", 1, 0]
end
