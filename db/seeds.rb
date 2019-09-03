User.create!(name: "admin",
  email: "admin@gmail.com",
  role: 1,
  password: "12345678",
  password_confirmation: "12345678")

User.create!(name: "user",
  email: "user@gmail.com",
  role: 0,
  password: "12345678",
  password_confirmation: "12345678")

40.times do |n|
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

subjects = Subject.includes(exams: {questions: :answers})
  .order(:created_at).take(5)
q_type_rand = Random.new
level = Random.new
100.times do
  subjects.each do |subject|
    qcontent = Faker::Lorem.unique.question(word_count: 5)
    q_type = q_type_rand.rand(1..2)
    if q_type == Question.question_types[:single_choice]
      subject.questions.create!(
        content: qcontent,
        supervisor_id: 1,
        question_type: q_type,
        level: level.rand(1..3),
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
        subject.questions.create!(
          content: qcontent,
          supervisor_id: 1,
          question_type: q_type,
          level: level.rand(1..3),
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

5.times do
  subjects.each do |subject|
    easy_q = 10
    normal_q = 10
    hard_q = 10
    total_score = easy_q + normal_q * 2 + hard_q * 3
    pass = Random.new
    num_q = easy_q + normal_q + hard_q
    exam = subject.exams.create!(
      name: Faker::Book.unique.title,
      time_limit: 60.minutes.to_i,
      number_question: num_q,
      pass_score: pass.rand(1..total_score),
      total_score: total_score
    )
    Exam::EXAM_TYPES.each do |type|
      qlist = Question.get_by_level_and_subject(Question.levels[type],
        subject.id).to_a
      binding.local_variable_get("#{type}_q").times do
        index = Random.new.rand(qlist.size)
        q = qlist.at(index)
        exam.add_question(qlist.slice!(index))
      end
    end
  end
end

exams = Exam.includes(questions: :answers).order(:created_at).take(5)
users = User.where(role: 0).pluck(:id)
5.times do
  exams.each do |exam|
    t_exam = exam.trainee_exams.create!(
      user_id: users.sample,
      complete_time: Random.new.rand(exam.time_limit.to_i)
    )
    exam.questions.each do |question|
      num_answers = question.answers.size
      if question.single_choice?
        de = t_exam.detail_exams.create!(question_id: question.id)
        question.answers.each_with_index do |answer, i|
          if i == 0
            de.detail_exam_answers.create!(
              answer_id: answer.id,
              checked: true
            )
          else
            de.detail_exam_answers.create!(
              answer_id: answer.id,
              checked: false
            )
          end
        end
      elsif question.multi_choice?
        de = t_exam.detail_exams.create!(question_id: question.id)
        question.answers.each do |answer|
          de.detail_exam_answers.create!(
            answer_id: answer.id,
            checked: Faker::Boolean.boolean
          )
        end
      end
    end
  end
end
