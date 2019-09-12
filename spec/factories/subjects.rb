FactoryBot.define do
  factory :subject do
    name {Faker::Lorem.unique.characters number: 10}
  end
end
