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



  scenario "admin successfully views cohorts" do
    user = FactoryGirl.create(:user)
    cohorts = FactoryGirl.create_list(:cohort, 3)
    # sign_in_as(user)
    visit cohorts_path

    expect(page).to have_content "Cohorts"
    expect(page).to have_content cohorts.first.term
    expect(page).to have_content cohorts.last.term
  end
end
