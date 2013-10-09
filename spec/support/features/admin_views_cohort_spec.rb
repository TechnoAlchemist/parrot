require 'spec_helper'

feature "admin_views_a_cohort", %Q{
  As an authenticated admin
  I want to view a current cohort
  So that I can see the students enrolled
 } do

#   Acceptance Criteria:
# * Admin must first be signed in
# * Admin can see the cohort name and the students enrolled
# * Admin may select an edit button to be redirected to a page where they can edit the cohort
# * Admin may select a delete button to delete the cohort
# * Admin will be asked to confirm edits or deletions before they are run

  let(:user) {FactoryGirl.create(:user)}
  let(:cohorts) {FactoryGirl.create_list(:cohort, 3)}

  scenario "admin successfully views cohorts" do
    sign_in_as(user)
    visit cohorts_path

    expect(page).to have_content "Cohorts"
    expect(page).to have_content cohorts.first.term
    expect(page).to have_content cohorts.last.term
  end

  scenario "admin successfully views a cohort" do
    cohort = cohorts.first
    sign_in_as(user)
    visit cohorts_path
    click_link cohorts.first.term

    expect(page).to have_content cohort.term
    expect(page).to have_content cohort.students
    expect(page).to have_content cohort.groups
    expect(page).to have_content "Edit"
    expect(page).to have_content "Delete"
  end

  scenario "unauthenticated user sees cohort info, but not Edit and Delete links" do
    visit cohorts_path
    click_link cohorts.first.term

    expect(page).to have_content cohorts.first.term
    expect(page).to_not have_content "Edit"
    expect(page).to_not have_content "Delete"
  end
end
