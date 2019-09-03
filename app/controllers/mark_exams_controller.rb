class MarkExamsController < ApplicationController
  def index
    @trainee_exams = TraineeExam.sort_by_subject_and_name.page(params[:page])
                                .per Settings.trainee_exams_per_page
  end
end
