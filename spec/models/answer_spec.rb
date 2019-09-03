require "rails_helper"

RSpec.describe Answer, type: :model do

  let(:question) {FactoryBot.create :question}
  subject {FactoryBot.create :answer, question_id: question.id}

  describe "Create" do
    it {is_expected.to be_valid}
  end

  describe "Database" do
    it {is_expected.to have_db_column(:content).of_type :string}
    it {is_expected.to have_db_column(:correct).of_type :boolean}
  end

  describe "Association" do
    it {is_expected.to belong_to :question}
    it {is_expected.to have_many :detail_exam_answers}
    it {is_expected.to have_many(:detail_exams).through :detail_exam_answers}
  end

  describe "Validates" do
    it {is_expected.to validate_presence_of(:content)
      .with_message(I18n.t("activerecord.errors.models.answer.attributes.content.blank"))}
  end
end
