require 'spec_helper'

feature "admin edits a project", %Q{
  As an authenticated admin
  I want to edit a specific project
  So that I can change information related to it

} do
#   Acceptance Criteria:
# * Admin must first be signed in
# * Admin may select an edit button to be redirect to a page 
# * where they can edit the project

  # let!(:project){FactoryGirl.create(:project)}
  # let!(:user){FactoryGirl.create(:user)}
  let!(:cohort){FactoryGirl.create(:cohort)}

    scenario "admin can edit a project" do
    # sign_in_as(user)
    project = FactoryGirl.create(:project, cohort: cohort)
    visit edit_cohort_project_path(cohort, project)
    fill_in "Title", with: "BlackJack"
    fill_in "Link", with: "www.fakewebsite.com"
    select "Fall", from: "Cohort"
    click_on "Edit Project"
    
    expect(page).to have_content("Project successfully edited")
    expect(Project.last.title).to eql("BlackJack")
  end

  scenario "admin enters invalid information" do
    # sign_in_as(user)
    project = FactoryGirl.create(:project, cohort: cohort)
    visit edit_cohort_project_path(cohort, project)
    fill_in "Title", with: ""
    fill_in "Link", with: ""
    select "Fall", from: ""
    click_on "Edit Project"
    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content(project.title)
  end

  scenario "student tries to edit a project" do
    pending
    student = FactoryGirl.create(:user, role: 'student')
    # sign_in_as(student)
    visit edit_cohort_project_path(cohort, project)
    fill_in "Title", with: "BlackJack"
    fill_in "Link", with: "www.fakewebsite.com"
    select "Fall", from: "Cohort"
    click_on "Edit Project"

    expect(page).to have_content("You do not have permission to edit projects")
    expect(page).to_not have_content(project.title)

  end
end
