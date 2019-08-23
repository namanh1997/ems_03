class Answer < ApplicationRecord
  belongs_to :question

  validates :content, presence: true
  validates_inclusion_of :correct,
    in: [true, false, "true", "false", 1, 0]
end
