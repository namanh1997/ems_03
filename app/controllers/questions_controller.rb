class QuestionsController < ApplicationController
  def index
    @questions = Question.sort_by_name.page(params[:page])
                         .per Settings.questions_per_page
  end

  def new
    @question = Question.new
  end

  def show
    @question = Question.find_by id: params[:id]
    return if @question
    flash[:danger] = t "no_question"
    redirect_to root_path
  end

  def create
    load_subject
    @question = @subject.questions.build question_params
    if @question.save
      flash[:info] = t "create_question_successful"
      redirect_to @question
    else
      flash.now[:danger] = t "create_question_failed"
      render :new
    end
  end

  private

  def load_subject
    @subject = Subject.find_by id: params[:subject][:id]
    return if @subject
    flash.now[:danger] = t "no_subject"
    render :new
  end

  def question_params
    params.require(:question).permit :content, :question_type,
      :level
  end
end
