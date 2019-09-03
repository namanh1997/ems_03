class TraineeExamsController < ApplicationController
  before_action :load_exam_new, only: :new
  before_action :load_exam_create, only: :create

  def index; end

  def create
    @trainee_exam = current_user.trainee_exams.build trainee_exam_params
    if @trainee_exam.save
      flash[:success] = t "submit_trainee_exam_successful"
      redirect_to root_url
    else
      flash.now[:danger] = t "submit_trainee_exam_failed"
      render :new
    end
  end

  def new
    @remaining_time = @exam.time_limit
    @trainee_exam = current_user.trainee_exams.build exam_id: params[:exam_id]
    load_questions_answers
  end

  private

  def load_exam_new
    @exam = Exam.load_questions_answers params[:exam_id]
    return if @exam
    flash[:danger] = t ".no_exam"
    redirect_to root_path
  end

  def load_exam_create
    @exam = Exam.load_questions_answers params[:trainee_exam][:exam_id]
    return if @exam
    flash[:danger] = t ".no_exam"
    redirect_to root_path
  end

  def load_questions_answers
    qlist = @exam.questions.to_a
    qlist.each do |question|
      @trainee_exam.detail_exams.build question_id: question.id
    end
    @trainee_exam.detail_exams.each do |de|
      de.question.answers.each do |answer|
        de.detail_exam_answers.build answer_id: answer.id
      end
    end
  end

  def trainee_exam_params
    params.require(:trainee_exam).permit TraineeExam::TRAINEE_EXAM_PARAMS
  end
end
