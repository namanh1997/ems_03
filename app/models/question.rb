class Question < ApplicationRecord
  belongs_to :subject
  has_many :answers

  delegate :name, to: :subject, prefix: true

  accepts_nested_attributes_for :subject

  scope :sort_by_name, ->{order :content}

  enum level: {easy: 0, normal: 1, hard: 2}
  enum question_type: {single_choice: 1, multi_choice: 2}

  validates :content, presence: true,
    length: {maximum: Settings.maximum_length_question_content},
    uniqueness: {case_sensitive: false}
end
