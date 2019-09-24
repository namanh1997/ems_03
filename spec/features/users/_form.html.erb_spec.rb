require "rails_helper"

RSpec.feature "Create trainee account", type: :feature do
  
  let!(:supervisor) {FactoryBot.create :user, role: 1}
  let!(:trainee) {FactoryBot.build :user, role: 0}
  before do
    visit signin_path
  end

  scenario "Supervisor login false, Flash unsuccess" do
    fill_in "session[email]", with: Faker::Name.name
    fill_in "session[password]", with: Faker::Lorem.unique.characters
    
    click_button "commit"
    expect(page).to have_text I18n.t "invalid"
  end


  scenario "Supervisor login, Supervisor create Trainee user successfully" do
    fill_in "session[email]", with: supervisor.email
    fill_in "session[password]", with: supervisor.password
    click_button "commit"
    visit new_user_path
    fill_in "user[name]", with: trainee.name
    fill_in "user[email]", with: trainee.email
    fill_in "user[password]", with: trainee.password
    fill_in "user[password_confirmation]", with: trainee.password
    choose ("user_role_trainee")

    click_button "commit"
    expect(page).to have_text I18n.t "create_user_successful"
  end

  scenario "Supervisor login, Supervisor create Trainee user unsuccessfully" do
    fill_in "session[email]", with: supervisor.email
    fill_in "session[password]", with: supervisor.password
    click_button "commit"
    visit new_user_path

    click_button "commit"
    expect(page).to have_text "The form contains 5 errors"
  end
end
