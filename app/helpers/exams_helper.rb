module ExamsHelper
  def question_level key
    Question.levels[key]
  end
end
