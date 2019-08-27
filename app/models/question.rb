class Question < ApplicationRecord
  QUESTION_PARAMS = [:content, :question_type, :level, :subject_id,
  answers_attributes: [:id, :content, :correct, :_destroy]].freeze

  belongs_to :subject
  has_many :exam_questions
  has_many :exams, through: :exam_questions
  has_many :answers, dependent: :destroy

  delegate :name, to: :subject, prefix: true
  delegate :content, :correct, to: :answers, prefix: true

  validates_presence_of :answers

  accepts_nested_attributes_for :answers,
    allow_destroy: true,
    reject_if: proc{|attributes| attributes["content"].blank?}

  scope :sort_by_name, ->{order :content}
  scope :get_by_id, ->(id){where id: id}

  enum level: {easy: 0, normal: 1, hard: 2}
  enum question_type: {single_choice: 1, multi_choice: 2}

  validates :content, presence: true,
    length: {maximum: Settings.maximum_length_question_content},
    uniqueness: {case_sensitive: false}

  def subject_id
    subject.id
  end
end
