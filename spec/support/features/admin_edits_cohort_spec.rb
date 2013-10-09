require 'spec_helper'

feature "admin_edits_a_cohort" do

  let(:user) {FactoryGirl.create(:user)}
  let(:cohort) {FactoryGirl.create(:cohort)}

  scenario "user successfully edits cohort" do
    prev_count = Cohort.count
    sign_in_as(user)
    visit edit_cohort_path
    fill_in "Term", with: "Fall"
    click_button "Update Cohort"

    expect(page).to have_content "You have successfully updated the cohort"
    expect(Cohort.count).to eql(prev_count)
    expect(page).to have_content "Fall"
  end

  scenario "signed in user fails to edit cohort" do
    sign_in_as(user)
    visit edit_cohort_path
    fill_in "Term", with: ""
    click_button "Update Cohort"

    expect(page).to_not have_content "You have successfully updated the cohort"
    expect(page).to have_content "can't be blank"
    expect(page).to_not have_content "Fall"
  end

  scenario "unauthenticated user fails to access edit cohort page" do
    visit edit_cohort_path

    expect(page).to have_content "You must be signed in to view this page"
    expect(page).to_not have_content "Update"
  end
end
