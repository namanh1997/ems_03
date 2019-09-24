require "rails_helper"

RSpec.describe "users/_form.html.erb" do
  let!(:user) {User.new}
  subject {rendered}

  before do
    assign :user, user
    render
  end

  context "should have user content" do
    it {is_expected.to have_field "user[name]"}
  end

  context "should have user email" do
    it {is_expected.to have_field "user[email]"}
  end

  context "should have user password" do
    it {is_expected.to have_field "user[password]"}
  end

  context "should have user confirmation" do
    it {is_expected.to have_field "user[password_confirmation]"}
  end

  context "should have check radiobutton trainee" do
    it {is_expected.to have_checked_field "user_role_trainee"}
  end

  context "should have uncheck radiobutton supervisor" do
    it {is_expected.to have_unchecked_field "user_role_supervisor"}
  end

  context "should have button create" do
    it {is_expected.to have_button "commit"}
  end
  
end
