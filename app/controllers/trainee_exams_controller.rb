class TraineeExamsController < ApplicationController
  before_action :load_exam, only: :new

  def index; end

  def create
    if @trainee_exam.save
      flash[:success] = t "submit_trainee_exam_successful"
      redirect_to @question
    else
      flash.now[:danger] = t "submit_trainee_exam_failed"
      render :new
    end
  end

  def new
    @remaining_time = Settings.remaining_time
    @trainee_exam = current_user.trainee_exams.new exam_id: params[:exam_id]
  end

  private

  def load_exam
    @exam = Exam.find_by id: params[:exam_id]
    return if @exam
    flash[:danger] = t ".no_exam"
    redirect_to root_path
  end

  def trainee_exam_params
    params.require(:trainee_exam).permit TraineeExam::TRAINEE_EXAM_PARAMS
  end
end
