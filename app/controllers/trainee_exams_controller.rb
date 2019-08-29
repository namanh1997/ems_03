class TraineeExamsController < ApplicationController
  before_action :load_exam, only: :new

  def index; end

  def create; end

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
end
