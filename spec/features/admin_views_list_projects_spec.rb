require 'spec_helper'

feature "admin views a project", %Q{
  As an authenticated admin
  I want to view a specific project
  So that I can see more information about the project

} do
#   Acceptance Criteria:
# * Admin must first be signed in
# * Admin can see a list of project titles

  let(:projects){FactoryGirl.create_list(:project, 3)}
  let(:user){FactoryGirl.create(:user)}
  let(:cohort){FactoryGirl.create(:cohort)}

  scenario "views a list of projects" do
    sign_in_as(user)
    visit cohort_projects_path(cohort)

    expect(page).to have_content('Projects')
    expect(page).to have_content(projects.first.title)
    expect(page).to have_content(projects.last.title)

  end
end
