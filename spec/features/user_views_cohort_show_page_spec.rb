require 'spec_helper'

feature "User views cohort show page", %Q{
  As an authenticated admin User
  I want to view a particular cohort
  So that I can see all the information pertaining to it
} do

#   Acceptance Criteria
# * User must be authenticated admin
# * User should see cohort term name, students, and groups
# * User should see links to edit and delete the cohort information
# * unauthenticated users should be notified that they must sign in

  let!(:cohort) { FactoryGirl.create(:cohort) }
  let!(:project) { FactoryGirl.create(:project, cohort: cohort) }
  let!(:group) {FactoryGirl.create(:group, project: project) }
  let!(:user) {FactoryGirl.create(:user, cohort: cohort) }
  let!(:membership) { FactoryGirl.create(:group_membership, user: user, group: group) }

  scenario "admin successfully views a cohort" do

      # sign_in_as(user)
      visit cohorts_path
      click_link cohort.term

      expect(page).to have_content cohort.term
      expect(page).to have_content user.username
      expect(page).to have_content project.title
      expect(page).to have_content group.group_memberships.count
      expect(page).to have_content "Edit"
      expect(page).to have_content "Delete"
    end

  context "as a student user" do
    scenario "user sees cohort info, but not Edit and Delete links" do
      pending visit cohorts_path
      click_link cohort.term

      expect(page).to have_content cohort.term
      expect(page).to_not have_content "Edit"
      expect(page).to_not have_content "Delete"
    end
  end

  context "as an unauthenticated user" do
    scenario "user sees cohort info, but not Edit and Delete links" do
      pending visit cohorts_path
      click_link cohort.term

      expect(page).to have_content cohort.term
      expect(page).to_not have_content "Edit"
      expect(page).to_not have_content "Delete"
    end
  end
end
