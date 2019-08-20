class Subject < ApplicationRecord
  has_many :exams
  has_many :questions

  scope :sort_by_name, ->{order :name}

  validates :name, presence: true,
    length: {maximum: Settings.maximum_length_name}
end
