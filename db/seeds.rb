User.create!(name: "admin",
             email: "admin@gmail.com",
             role: 1,
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

subjects = Subject.order(:created_at).take(5)
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

5.times do
  subjects.each do |subject|
    easy_q = 10
    normal_q = 10
    hard_q = 10
    max_score = easy_q + normal_q * 2 + hard_q * 3
    num_q = easy_q + normal_q + hard_q
    exam = subject.exams.create!(
      name: Faker::Name.unique.name,
      time_limit: 60.minutes.to_i,
      number_question: num_q,
      total_score: max_score,
      pass_score: Random.new.rand(1..max_score)
    )
    easy_q.times do
      exam.add_question(Question
        .get_by_level_and_subject(Question.levels[:easy], subject.id).sample)
    end
    normal_q.times do
      exam.add_question(Question
        .get_by_level_and_subject(Question.levels[:normal], subject.id).sample)
    end
    hard_q.times do
      exam.add_question(Question
        .get_by_level_and_subject(Question.levels[:hard], subject.id).sample)
    end
  end
end

exams = Exam.order(:created_at).take(5)
users = User.where(role: 0).take(10)
5.times do
  exams.each do |exam|
    score =  Random.new.rand(exam.total_score.to_i)
    t_exam = exam.trainee_exams.create!(
      user_id: users.sample.id,
      total_score: score,
      complete_time: Random.new.rand(exam.time_limit.to_i),
      is_passed: (score >= exam.pass_score)
    )
    exam.questions.each do |question|
      num_answers = question.answers.size
      if question.single_choice?
        t_exam.detail_exams.create!(
          trainee_exam_id: t_exam.id,
          question_id: question.id,
        ).answers << question.answers.sample
      elsif question.multi_choice?
        t_exam.detail_exams.create!(
          trainee_exam_id: t_exam.id,
          question_id: question.id,
        ).answers << question.answers.sample(Random.new.rand(num_answers-1))
      end
    end
  end
end
