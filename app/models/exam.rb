class Exam < ApplicationRecord
  EXAM_TYPES = %w(easy normal hard).freeze
  EXAM_PARAMS = [:name, :pass_score, :number_question,
    :subject_id, :total_score].freeze

  belongs_to :subject
  has_many :trainee_exams
  has_many :exam_questions
  has_many :questions, through: :exam_questions

  delegate :id, :name, to: :subject, prefix: true

  scope :sort_by_name, ->{order :name}
  scope :load_detail,
    ->(id){includes(questions: :answers).where(id: id).first}

  validates :name, presence: true,
    length: {maximum: Settings.maximum_length_name}

  validates :pass_score, presence: true
  validates :total_score, presence: true
  validates :number_question, presence: true
  validates :time_limit, presence: true

  def add_question question
    questions << question
  end

  def remove_question question
    questions.delete question
  end
end
