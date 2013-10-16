require 'spec_helper'

feature "admin edits a project", %Q{
  As an authenticated admin
  I want to edit a specific project
  So that I can change information related to it

} do
#   Acceptance Criteria:
# * Admin must first be signed in
# * Admin may select a delete button to be redirected to a page 
# * where they can delete the project

  let!(:cohort){FactoryGirl.create(:cohort)}
  


  scenario "admin deletes a project" do
    project = FactoryGirl.create(:project, cohort: cohort)    
    prev_count = Project.count
    set_omniauth
    sign_in
    visit cohort_project_path(cohort, project)
    click_on 'Delete'

    expect(page).to_not have_content(project.title)
    expect(Project.count).to eql(prev_count - 1)
  end

  scenario "unauthenticated user tries to delete a project" do
    project = FactoryGirl.create(:project, cohort: cohort)
    visit cohort_project_path(cohort, project)

    expect(page).to_not have_content("Delete")
  end
end
