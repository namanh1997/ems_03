class DetailExamAnswer < ApplicationRecord
  belongs_to :detail_exam
  belongs_to :answer

  delegate :content, :correct, to: :answer, prefix: true
end
