FactoryBot.define do
  factory :supervisor do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    address {Faker::Address.city}
    phone {Faker::PhoneNumber
      .subscriber_number length: Settings.factories.user.phone_length}
    password {Faker::Lorem.characters number: Settings.factories.user.pass_length}
    role {User.roles.key(User.roles[:supervisor])}
  end

  FactoryBot.define do
    factory :user do
      name {Faker::Name.name}
      email {Faker::Internet.unique.email}
      address {Faker::Address.country}
      password {Faker::Lorem.unique.characters number: 6}
      phone {Faker::PhoneNumber.phone_number[9..14]}
      role {User.roles.key(User.roles[:trainee])}
    end
  end
end
