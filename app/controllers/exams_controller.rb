class ExamsController < ApplicationController
  before_action :supervisor_user, except: %i(index show)
  before_action :load_subject, only: %i(new index)
  before_action :load_subject_create, only: :create

  def index
    @exams = @subject.exams.sort_by_name.page(params[:page])
                     .per Settings.exams_per_page
  end

  def create
    @exam = @subject.exams.build exam_params
    add_questions
    update_time_limit

    if @exam.save
      flash[:success] = t "create_exam_successful"
      redirect_to subject_index_path
    else
      flash.now[:danger] = t "create_exam_failed"
      render :new
    end
  end

  def new
    @exam = Exam.new
    @exam.subject = @subject
  end

  def edit; end

  def show
    @exam = Exam.find_by id: params[:id]
    return if @exam
    flash[:danger] = t "no_exam"
    redirect_to root_path
  end

  def update
    if @exam.update exam_params
      redirect_to @exam
    else
      render :edit
    end
  end

  def destroy; end

  private

  def load_subject
    @subject = Subject.find_by id: params[:subject_id]
    return if @subject
    flash[:danger] = t "no_subject"
    redirect_to subject_index_path
  end

  def add_questions
    Exam::EXAM_TYPES.each do |type|
      params[:exam][:"#{type}_question"].to_i.times do
        @exam.add_question(Question.get_by_level_and_subject(
          Question.levels[type], @subject.id
        ).sample)
      end
    end
  end

  def load_subject_create
    @subject = Subject.find_by id: params[:exam][:subject_id]
    return if @subject
    flash.now[:danger] = t "no_subject"
    render :new
  end

  def load_exam
    @exam = Exam.find_by id: params[:id]
    return if @exam
    flash[:danger] = t "no_exam"
    redirect_to root_path
  end

  def exam_params
    params.require(:exam).permit Exam::EXAM_PARAMS
  end

  def update_time_limit
    @exam.time_limit = params[:exam][:hours].to_i * Settings.hours +
                       params[:exam][:minutes].to_i * Settings.minutes
  end
end
