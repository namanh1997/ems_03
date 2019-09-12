FactoryBot.define do
  factory :exam do
    name {Faker::Lorem.unique.characters number: 5}
    time_limit {Settings.factories.exam.time_limit}
    pass_score {Settings.factories.exam.pass_score}
    total_score {Settings.factories.exam.total_score}
    number_question {Settings.factories.exam.number_question}
    association :subject

    factory :exam_with_questions do
      transient do
        questions_count {3}
      end
      
      after(:create) do |exam|
        exam.questions << FactoryBot.create_list(:question, 3)
      end
    end
  end
end
