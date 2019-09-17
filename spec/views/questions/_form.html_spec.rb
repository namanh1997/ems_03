require "rails_helper"

RSpec.describe "questions/_form.html.erb" do
  let!(:question) {Question.new}
  subject {rendered}

  before do
    assign :question, question
    question.answers.build
    render
  end

  context "should have select subject option" do
    it {is_expected.to have_select "subject[id]"}
  end

  context "should have question content" do
    it {is_expected.to have_field "question[content]"}
  end

  context "should have select question level" do
    it {is_expected.to have_select "question[level]"}
  end

  context "should have check radiobutton single correct answer" do
    it {is_expected.to have_checked_field "question_question_type_single_choice"}
  end

  context "should have uncheck radiobutton multiple correct answer" do
    it {is_expected.to have_unchecked_field "question_question_type_multi_choice"}
  end

  describe "questions/_answer_fields" do
    before do
      form_for question do |f|
        f.fields_for :answers do |answer|
          render "questions/answer_fields", f: answer
        end
      end
    end
    
    context "should have answer content" do
      it {is_expected.to have_field "question[answers_attributes][0][content]"}
    end
    
    context "should have uncheck checkbox for correct answer" do
      it {is_expected.to have_unchecked_field "question[answers_attributes][0][correct]"}
    end

    context "should have check single correct answer" do
      it {is_expected.to have_link "Delete Answer"}
    end

    context "should have check single correct answer" do
      it {is_expected.to have_link "Add answer"}
    end

    context "should have check single correct answer" do
      it {is_expected.to have_button "commit"}
    end
  end
end
