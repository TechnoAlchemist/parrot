require 'spec_helper'

feature "admin_creates_a_cohort", %Q{
  As an authenticated admin
  I want to create a cohort
  So that I can manage current students and projects
} do

#   Acceptance Criteria:
# * Admin must be signed in to Parrot
# * Admin must enter cohort term
# * If the admin attempts to create a cohort without entering required information,
#   they will receive an error message


  let(:user) {FactoryGirl.create(:user)}
  let(:cohort) {FactoryGirl.build(:cohort)}

  scenario "admin successfully creates cohort" do
    prev_count = Cohort.count
    sign_in_as(user)
    visit new_cohort_path
    fill_in "Term", with: cohort.term
    click_button "Create New Cohort"

    expect(page).to have_content "A new cohort has been created"
    expect(Cohort.count).to eql(prev_count + 1)
  end

  scenario "admin fails to create cohort" do
    prev_count = Cohort.count
    sign_in_as(user)
    visit new_cohort_path
    click_button "Create New Cohort"

    expect(page).to_not have_content "A new cohort has been created"
    expect(page).to have_content "can't be blank"
    expect(Cohort.count).to eql(prev_count)
  end
    scenario "unauthenticated user visits new cohort page and can not create cohort" do
      visit new_cohort_path

      expect(page).to have_content "You must be signed in to view this page"
      expect(page).to_not have_content "Term"
    end
end



