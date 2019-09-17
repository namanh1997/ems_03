FactoryBot.define do
  factory :supervisor do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    address {Faker::Address.city}
    phone {Faker::PhoneNumber
      .subscriber_number length: Settings.factories.user.phone_length}
    password {Faker::Lorem.characters number: Settings.factories.user.pass_length}
    role {Settings.factories.user.supervisor_role}
  end

  FactoryBot.define do
    factory :user do
      name {Faker::Name.name}
      email {Faker::Internet.unique.email}
      address {Faker::Address.country}
      password {Faker::Lorem.unique.characters number: 6}
      phone {Faker::PhoneNumber.phone_number[9..14]}
      role {Random.new.rand 0..1}
    end
  end
end
