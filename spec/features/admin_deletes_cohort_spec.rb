require 'spec_helper'

feature "admin_deletes_a_cohort", %Q{
  As an Admin user
  I want to delete a cohort
  So that I can eliminate it from the system
} do

#   Acceptance Criteria
# * Admin must be signed in
# * Admin will be notified when the delete is successful
# * unauthenticated users can not see delete link

  let!(:cohort) {FactoryGirl.create(:cohort)}
  let!(:user) {FactoryGirl.create(:user, cohort: cohort)}

  scenario "admin successfully deletes cohort" do
    prev_count = Cohort.count
    # sign_in_as(user)
    visit cohorts_path
    click_link cohort.term
    click_link "Delete"

    expect(Cohort.count).to eql(prev_count - 1)
    expect(page).to_not have_content cohort.term
  end

  context "as a student user" do
    scenario "user can not delete cohort" do
      pending visit cohorts_path
      click_link cohort.term

      expect(page).to_not have_content "Delete"
    end
  end

  context "as an unauthenticated user" do
    scenario "user can not delete cohort" do
      pending visit cohorts_path
      click_link cohort.term

      expect(page).to_not have_content "Delete"
    end
  end
end
