class User < ApplicationRecord
  devise :database_authenticatable, :confirmable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :questions
  has_many :trainee_exams, dependent: :destroy
  before_save :downcase_email
  enum role: {trainee: 0, supervisor: 1}
  validates :name, presence: true,
    length: {maximum: Settings.maximum_length_name}
  validates :phone,
    length: {maximum: Settings.maximum_length_phone}

  scope :sort_by_name, ->{order :name}

  private

  def downcase_email
    email.downcase!
  end
end
