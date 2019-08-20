class User < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :trainee_exams, dependent: :destroy
  enum role: {customer: 0, supervisor: 1}
  validates :name, presence: true,
    length: {maximum: Settings.maximum_length_name}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.maximum_length_email},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true,
    length: {minimum: Settings.minimum_length_pass}
  validates :phone,
    length: {maximum: Settings.maximum_length_phone}

  scope :sort_by_name, ->{order :name}
end
