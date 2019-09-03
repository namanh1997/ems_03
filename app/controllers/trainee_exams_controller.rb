class TraineeExamsController < ApplicationController
  before_action :load_exam_new, :signed_in_user, only: %i(new do_exam)
  before_action :load_trainee_exam_new, only: :do_exam
  before_action :load_exam_create, only: :create
  before_action :supervisor_user, only: %i(edit update)
  before_action :load_trainee_exam, only: %i(edit show update)
  before_action :check_score, :check_pass, only: :update

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
    @trainee_exam = current_user.trainee_exams.build exam_id: params[:exam_id]
    if @trainee_exam.save
      flash.now[:success] = t "submit_trainee_exam_successful"
      redirect_to do_exam_path(trainee_exam_id: @trainee_exam.id,
        exam_id: params[:exam_id])
    else
      flash.now[:danger] = t "submit_trainee_exam_failed"
      render :new
    end
  end

  def edit; end

  def do_exam
    @remaining_time = @exam.time_limit - (Time.now.to_i -
      @trainee_exam.created_at.to_i)
    load_questions_answers
  end

  def update
    if @trainee_exam.save
      flash[:success] = t "trainee_exam_marked"
    else
      flash[:danger] = t "trainee_exam_marked_failed"
    end
    redirect_to mark_exams_path
  end

  private

  def load_exam_new
    @exam = Exam.load_detail params[:exam_id]
    return if @exam
    flash[:danger] = t "no_exam"
    redirect_to root_path
  end

  def load_trainee_exam_new
    @trainee_exam = TraineeExam.trainee_exam_result params[:trainee_exam_id]
    return if @trainee_exam
    flash[:danger] = t ".no_exam"
    redirect_to root_path
  end

  def load_exam_create
    @exam = Exam.load_questions_answers params[:trainee_exam][:exam_id]
    return if @exam
    flash[:danger] = t "no_exam"
    redirect_to root_path
  end

  def load_trainee_exam
    @trainee_exam = TraineeExam.trainee_exam_result params[:id]
    return if @trainee_exam
    flash[:danger] = t "no_trainee_exam"
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

  def check_score
    @trainee_exam.total_score = 0
    check_result
  end

  def check_result
    @trainee_exam.detail_exams.each do |de|
      de.detail_exam_answers.each do |dea|
        if dea.checked && dea.answer.correct
          de.is_result = true
        elsif !dea.checked && !dea.answer.correct
          next
        else
          de.is_result = false
          break
        end
      end
      if de.is_result == true
        @trainee_exam.total_score += Question.levels[de.question.level]
      end
    end
  end

  def trainee_exam_params
    params.require(:trainee_exam).permit TraineeExam::TRAINEE_EXAM_PARAMS
  end

  def check_pass
    te = @trainee_exam
    @trainee_exam.is_passed = te.total_score >= te.exam.pass_score
  end
end
