class TraineeExamController < ApplicationController
  def index; end

  def create; end

  def new
    @remaining_time = Settings.remaining_time
  end
  
end
