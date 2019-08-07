class Exam < ApplicationRecord
  belongs_to :subject
  has_many :trainee_exams

  validates :name, presence: true,
    length: {maximum: Settings.maximum_length_name}

  validates :time_limit, presence: true
  validates :pass_score, presence: true
  validates :number_question, presence: true
end
