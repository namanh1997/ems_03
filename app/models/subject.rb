class Subject < ApplicationRecord
  has_many :exams
  has_many :questions
  validates :name, presence: true,
    length: {maximum: Settings.maximum_length_name}
end
