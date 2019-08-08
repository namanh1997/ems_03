class Question < ApplicationRecord
  belongs_to :subject
  enum level: {easy: 0, normal: 1, hard: 2}
  enum type: {signle choice: 1, multi choice: 2}
  validates :content, presence: true
end
