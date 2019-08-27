class Exam < ApplicationRecord
  attr_accessor :easy_question, :normal_question, :hard_question

  EXAM_PARAMS = [:name, :time_limit, :pass_score, :number_question,
    :subject_id, :total_score].freeze

  belongs_to :subject
  has_many :trainee_exams
  has_many :exam_questions
  has_many :questions, through: :exam_questions

  delegate :id, to: :subject, prefix: true

  scope :sort_by_name, ->{order :name}

  validates :name, presence: true,
    length: {maximum: Settings.maximum_length_name},
    uniqueness: {case_sensitive: false}

  validates :time_limit, presence: true
  validates :pass_score, presence: true
  validates :total_score, presence: true
  validates :number_question, presence: true

  def add_question question
    questions << question
  end

  def remove_question question
    question.delete question
  end
end
