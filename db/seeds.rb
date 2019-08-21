User.create!(name: "admin",
             email: "admin@gmail.com",
             role: 1,
             password: "12345678",
             password_confirmation: "12345678")

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

Subject.create!([{name: "Ruby"},
  {name: "MySql"},
  {name: "Git"},
  {name: "Rails"},
  {name: "HTML"},
  {name: "CSS"},
  {name: "Javascript"}
])

subjects = Subject.order(:created_at).take(6)
q_type = Random.new
level = Random.new
50.times do
  content = Faker::Lorem.sentence(5)
  subjects.each { |subject| subject.questions
    .create!(content: content,
             supervisor_id: 1,
             question_type: q_type.rand(1..2),
             level: level.rand(3)) }
end
