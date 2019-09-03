FactoryBot.define do
  factory :question do
    supervisor_id {Settings.factories.question.supervisor_id}
    content {Faker::Lorem.unique.question(word_count: 5)}
    question_type {Random.new.rand 1..2}
    level {Random.new.rand 1..3}
    association :subject

    before(:create) do |question|
      question.answers << FactoryBot.build_list(:answer, 4, question: question)
    end
  end
end
