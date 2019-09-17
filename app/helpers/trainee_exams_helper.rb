module TraineeExamsHelper
  def total_correct_questions trainee_exam
    count = 0
    trainee_exam.detail_exams.each do |de|
      count += 1 if de.is_result?
    end
    count
  end

  def question_level key
    Question.levels[key]
  end

  def question_score detail_exam
    if detail_exam.is_result?
      Question.levels[detail_exam.question.level]
    else
      Settings.zero
    end
  end
end
