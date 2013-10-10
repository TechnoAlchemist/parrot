require 'spec_helper'

feature "admin_edits_a_cohort", %Q{
    As an authenticated admin user
    I want to edit a cohort
    so that when circumstances change the system can be updated
  } do

#   Acceptance Criteria
# * Admin must be signed into the system
# * Admin will be notified when the update is successful
# * Admin will be given error message after failure


  let(:user) {FactoryGirl.create(:user)}
  let(:cohort) {FactoryGirl.create(:cohort)}

  scenario "user successfully edits cohort" do
    visit new_cohort_path
    fill_in "Term", with: cohort.term
    click_button "Create New Cohort"
    prev_count = Cohort.count
    # sign_in_as(user)
    visit edit_cohort_path(cohort)
    fill_in "Term", with: "Winter"
    click_button "Update Cohort"

    expect(page).to have_content "You have successfully updated the cohort"
    expect(Cohort.count).to eql(prev_count)
    expect(page).to have_content "Winter"
  end

  scenario "signed in user fails to edit cohort" do
    # sign_in_as(user)
    visit edit_cohort_path(cohort)
    fill_in "Term", with: ""
    click_button "Update Cohort"

    expect(page).to_not have_content "You have successfully updated the cohort"
    expect(page).to have_content "can't be blank"
  end

  scenario "unauthenticated user fails to access edit cohort page" do
    pending visit edit_cohort_path(cohort)

    expect(page).to have_content "You must be signed in to view this page"
    expect(page).to_not have_content "Update"
  end
end
