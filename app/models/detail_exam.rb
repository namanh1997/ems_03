class DetailExam < ApplicationRecord
  belongs_to :trainee_exam
  belongs_to :question
end
