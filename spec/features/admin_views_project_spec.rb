require 'spec_helper'

feature "admin views a project", %Q{
  As an authenticated admin
  I want to view a specific project
  So that I can see more information about the project

} do
#   Acceptance Criteria:
# * Admin must first be signed in
# * Admin can see the project name, the link, 
# * the associated cohort, and the pairing assignments (if any)
# * Admin may select an edit button to be redirect to a page 
# * where they can edit the project
# * Admin may select a delete button to be redirected to a page 
# * where they can delete the project
# * Admin will be asked to confirm edits or deletions before they are run

  let(:project){FactoryGirl.create(:project)}
  let(:user){FactoryGirl.create(:user)}


  scenario "has a list of the various projects" do
    sign_in_as(user)
    visit_cohort_project_path
    
    expect(page).to have_content(project.title)
    expect(project).to have_content(project.link)
  end

  scenario "admin can edit a project" do
    project2 = FactoryGirl.create(:project)
    sign_in_as(user)
    visit_cohort_project_path
    expect(page).to have_content(project2.title)
    click_on 'Edit'
    
    visit_edit_cohort_project
    fill_in "Title", with: "BlackJack"
    fill_in "Link", with: "www.fakewebsite.com"
    select "Fall", from: "Cohort"
    click_on "Submit"
    
    expect(page).to have_content(project2.title = "BlackJack")
    expect(page).to have_content("BlackJack")
  end

  scenario "admin deletes a project" do
    prev_count = Project.count
    project3 = FactoryGirl.create(:project)
    
    sign_in_as(user)
    visit_cohort_project_path
    expect(page).to have_content(project3.link)
    click_on 'Delete'

    expect(page).to_not have_content(project.title)
    expect(Project.count).to eql(prev_count)
  end
end
