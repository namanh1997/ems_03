class QuestionsController < ApplicationController
  before_action :load_subject, only: :create
  before_action :load_question, except: %i(index new create)
  before_action :supervisor_user, only: :destroy

  def index
    @questions = Question.sort_by_name.page(params[:page])
                         .per Settings.questions_per_page
  end

  def show; end

  def new
    @question = Question.new
    @question.answers.build
  end

  def create
    @question = @subject.questions.build question_params
    if @question.save
      flash[:success] = t "create_question_successful"
      redirect_to @question
    else
      flash.now[:danger] = t "create_question_failed"
      render :new
    end
  end

  def edit
    @answers = @question.answers
    @subject = @question.subject
  end

  def update
    if @question.update_attributes question_params
      flash[:success] = t "question_update"
      redirect_to @question
    else
      flash.now[:danger] = t "question_update_failed"
      render :edit
    end
  end

  def destroy
    if @question.destroy
      flash[:success] = t "question_destroyed"
    else
      flash[:danger] = t "question_destroyed_failed"
    end
    redirect_to questions_url
  end

  private

  def load_subject
    @subject = Subject.find_by id: params[:subject][:id]
    return if @subject
    flash.now[:danger] = t "no_subject"
    render :new
  end

  def load_question
    @question = Question.find_by id: params[:id]
    return if @question
    flash[:danger] = t "no_question"
    redirect_to root_path
  end

  def question_params
    params.require(:question).permit Question::QUESTION_PARAMS
  end
end
