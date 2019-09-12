require "rails_helper"

RSpec.describe Exam, type: :model do
  subject {FactoryBot.create :exam}

  describe "Create" do
    it {is_expected.to be_valid}
  end

  describe "Database" do
    it {is_expected.to have_db_column(:name).of_type :string}
    it {is_expected.to have_db_column(:pass_score).of_type :integer}
    it {is_expected.to have_db_column(:total_score).of_type :integer}
    it {is_expected.to have_db_column(:number_question).of_type :integer}
    it {is_expected.to have_db_column(:time_limit).of_type :integer}
  end

  describe "Association" do
    it {is_expected.to belong_to :subject}
    it {is_expected.to have_many :exam_questions}
    it {is_expected.to have_many :trainee_exams}
    it {is_expected.to have_many(:questions).through :exam_questions}
  end

  describe "name" do
    context "valid" do
      it {is_expected.to validate_presence_of(:name)
        .with_message(I18n.t("activerecord.errors.models.exam.attributes.name.blank"))}
      it {is_expected.to validate_length_of(:name)
        .is_at_most(Settings.factories.exam.name_max_length)
        .with_message(I18n.t("activerecord.errors.models.exam.attributes.name.too_long"))}
    end

    context "invalid" do
      before {subject.name = "a" * Settings.factories.exam.name_invalid_length}
      it {is_expected.not_to be_valid}
    end
  end

  describe "Validates rest" do
    it {is_expected.to validate_presence_of(:pass_score)
      .with_message(I18n.t("activerecord.errors.models.exam.attributes.pass_score.blank"))}
    it {is_expected.to validate_presence_of(:total_score)
      .with_message(I18n.t("activerecord.errors.models.exam.attributes.total_score.blank"))}
    it {is_expected.to validate_presence_of(:number_question)
      .with_message(I18n.t("activerecord.errors.models.exam.attributes.number_question.blank"))}
    it {is_expected.to validate_presence_of(:time_limit)
      .with_message(I18n.t("activerecord.errors.models.exam.attributes.time_limit.blank"))}
  end

  describe "Scopes" do
    context "sort by name" do
      let(:exam1) {FactoryBot.create :exam, name: "c"}
      let(:exam2) {FactoryBot.create :exam, name: "a"}
      let(:exam3) {FactoryBot.create :exam, name: "B"}

      it "should order by name" do
        expect(Exam.sort_by_name).to eq [exam2, exam3, exam1]
      end
    end

    context "load detail" do
      let(:exam) {FactoryBot.create :exam_with_questions}

      it "should load questions" do
        expect(Exam.load_detail(exam.id).questions).to eq exam.questions
      end

      it "should load answers" do
        list1 = Exam.load_detail(exam.id).questions
        list2 = exam.questions
        list1.zip list2 do |question1, question2|
          expect(question1.answers).to eq question2.answers
        end
      end
    end
  end

  describe "#add_question" do
    let(:question1) {FactoryBot.create :question}
    let(:question2) {FactoryBot.create :question}
    before {subject.questions << [question1, question2]}

    it "should add question1" do
      expect(subject.questions.first).to eq question1
    end
    it "should add question2" do
      expect(subject.questions.second).to eq question2
    end
  end

  describe "#remove_question" do
    let(:question1) {FactoryBot.create :question}
    let(:question2) {FactoryBot.create :question}
    before {subject.questions << [question1, question2]}

    it "should remove question1" do
      expect(subject.questions.delete(question1)).to eq [question1]
    end
    it "should remove question2" do
      expect(subject.questions.delete(question2)).to eq [question2]
    end
  end
end
