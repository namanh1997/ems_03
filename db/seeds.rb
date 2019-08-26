User.create!(name: "admin",
             email: "admin@gmail.com",
             role: 1,
             password: "12345678",
             password_confirmation: "12345678")

50.times do |n|
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
q_type_rand = Random.new
level = Random.new
50.times do
  subjects.each do |subject|
    qcontent = Faker::Lorem.unique.question(word_count: 5)
    q_type = q_type_rand.rand(1..2)
    if q_type == Question.question_types[:single_choice]
      question = subject.questions.create!(
        content: qcontent,
        supervisor_id: 1,
        question_type: q_type,
        level: level.rand(3),
        answers_attributes: [{
          content: Faker::Food.fruits,
          correct: true
        },
        {
          content: Faker::Verb.base,
          correct: false
        },
        {
          content: Faker::Lorem.word,
          correct: false
        },
        {
          content: Faker::Restaurant.name,
          correct: false
        }]
      )
    elsif q_type == Question.question_types[:multi_choice]
        question = subject.questions.create!(
          content: qcontent,
          supervisor_id: 1,
          question_type: q_type,
          level: level.rand(3),
          answers_attributes: [{
            content: Faker::Food.fruits,
            correct: true
          },
          {
            content: Faker::Verb.base,
            correct: true
          },
          {
            content: Faker::Lorem.word,
            correct: false
          },
          {
            content: Faker::Restaurant.name,
            correct: Faker::Boolean.boolean
          }]
        )
    end
  end
end
