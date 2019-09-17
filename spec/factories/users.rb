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

  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    address {Faker::Address.city}
    phone {Faker::PhoneNumber
      .subscriber_number length: Settings.factories.user.phone_length}
    password {Faker::Lorem.characters number: Settings.factories.user.pass_length}
    role {Settings.factories.user.supervisor_role}
  end
end
