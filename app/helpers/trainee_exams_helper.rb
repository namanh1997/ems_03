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
end
