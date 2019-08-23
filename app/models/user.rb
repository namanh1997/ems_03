class User < ApplicationRecord
  USER_PARAMS = %i(name email password password_confirmation role).freeze

  has_many :questions
  has_many :trainee_exams, dependent: :destroy
  before_save :downcase_email
  enum role: {trainee: 0, supervisor: 1}
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

  private

  def downcase_email
    email.downcase!
  end
end
