require "rails_helper"

RSpec.describe User, type: :model do
  subject {FactoryBot.create :user}

  describe "Create" do
    it {is_expected.to be_valid}
  end

  describe "Database" do
    it {is_expected.to have_db_column(:name).of_type :string}
    it {is_expected.to have_db_column(:email).of_type :string}
    it {is_expected.to have_db_column(:address).of_type :string}
    it {is_expected.to have_db_column(:password_digest).of_type :string}
    it {is_expected.to have_db_column(:role).of_type :integer}
  end

  describe "Association" do
    it {is_expected.to have_many :trainee_exams}
  end

  describe "name" do
    context "valid" do
      it {is_expected.to validate_presence_of(:name)
        .with_message(I18n.t("activerecord.errors.models.user.attributes.name.blank"))}
      it {is_expected.to validate_length_of(:name)
        .is_at_most(Settings.factories.user.name_max_length)
        .with_message(I18n.t("activerecord.errors.models.user.attributes.name.too_long"))}
    end

    context "invalid" do
      before {subject.name = "a" * Settings.factories.user.name_invalid_length}
      it {is_expected.not_to be_valid}
    end
  end

  describe "Validates rest" do
    it {is_expected.to validate_presence_of(:email)
      .with_message(I18n.t("activerecord.errors.models.user.attributes.email.blank"))}
  end

  describe "Scopes" do
    context "sort by name" do
      let(:user1) {FactoryBot.create :user, name: "c"}
      let(:user2) {FactoryBot.create :user, name: "a"}
      let(:user3) {FactoryBot.create :user, name: "B"}

      it "should order by name" do
        expect(User.sort_by_name).to eq [user2, user3, user1]
      end
    end 
  end

  describe "#downcase_email" do
    let(:user1) {FactoryBot.build :user, email: "AbC@gmail.Com"}

    it "should email downcase" do
      expect(user1.email.downcase!).to eq "abc@gmail.com"
    end
  end
end
