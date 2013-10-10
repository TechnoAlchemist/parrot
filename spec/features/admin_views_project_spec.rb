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
# * Admin will be asked to confirm edits or deletions before they are run


  let(:project){FactoryGirl.create(:project)}
  let(:user){FactoryGirl.create(:user)}
  let(:cohort){FactoryGirl.create(:cohort)}


  scenario "views a project" do
    sign_in_as(user)
    visit cohort_project_path(cohort, project)
    
    expect(page).to have_content(project.title)
    expect(page).to have_content(project.link)
    expect(page).to have_content('Delete')
    expect(page).to have_content('Edit')
  end
end
