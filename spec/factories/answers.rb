FactoryBot.define do
  factory :answer do
    content {Faker::Food.fruits}
    correct {Faker::Boolean.boolean}
    association :question
  end
end
