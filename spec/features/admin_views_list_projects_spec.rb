require 'spec_helper'

feature "admin views a project", %Q{
  As an authenticated admin
  I want to view a specific project
  So that I can see more information about the project

} do
#   Acceptance Criteria:
# * Admin must first be signed in
# * Admin can see a list of project titles

  let!(:cohort){FactoryGirl.create(:cohort)}

  

  scenario "views a list of projects" do
    projects = FactoryGirl.create_list(:project, 3, cohort: cohort)
    set_omniauth(role: "admin")
    sign_in
    visit cohort_projects_path(cohort)

    expect(page).to have_content('Projects')
    expect(page).to have_content(projects.first.title)
    expect(page).to have_content(projects.last.title)
  end

  scenario "unathenticated user tries to view list of projects" do
    projects = FactoryGirl.create_list(:project, 3, cohort: cohort)
    visit cohort_projects_path(cohort)
    expect(page).to_not have_content('Projects')
    expect(page).to have_content("You must be signed in to continue")
  end
end
