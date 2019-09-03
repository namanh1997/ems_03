FactoryBot.define do
  factory :exam_question do
    association :question, :exam
  end
end
