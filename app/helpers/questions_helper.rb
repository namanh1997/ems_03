module QuestionsHelper
  def subject_collection
    Subject.select :name, :id
  end

  def id
    :id
  end

  def name
    :name
  end

  def question_collection
    Question.select(:level).distinct
  end

  def level
    :level
  end
end
