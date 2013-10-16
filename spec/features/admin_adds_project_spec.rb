require 'spec_helper'

feature "admin adds a project to a cohort", %Q{
  As an authenticated admin
  I want to add a project to a cohort
  So that I can begin assigning pairs to that project
} do 

#   Acceptance Criteria:
# * Admin must first be signed in
# * Admin must enter valid project criteria (name, link, and associated cohort)
# * If admin does not enter valid criteria, they will receive an error message
# * If admin enters valid criteria, 
# * they will be redirected to a page for the project they have just created



let!(:cohort){FactoryGirl.create(:cohort)}
  
  scenario "enters valid information" do
    prev_count = Project.count
    set_omniauth(role: "admin")
    sign_in
    visit new_cohort_project_path(cohort)
    fill_in "Title", with: "Hangman"
    fill_in "Link", with: "www.fakewebsite.com"
    select "Fall", from: "Cohort"
    click_on "Create New Project"
    
    expect(page).to have_content("Project successfully created")
    expect(page).to have_content("Hangman")
    expect(Project.count).to eql(prev_count +1)
  end

  scenario "enters invalid information" do
    prev_count = Project.count
    set_omniauth(role: "admin")
    sign_in
    visit new_cohort_project_path(cohort)
    click_on "Create New Project"
    
    expect(page).to_not have_content("Hangman")
    expect(Project.count).to eql(prev_count)
    expect(page).to have_content("can't be blank")
  end

  scenario "unauthenticated user tries to add project" do
    visit new_cohort_project_path(cohort)

    expect(page).to have_content("You must be signed in to continue")
  end

  scenario "student tries to add a project" do
    set_omniauth
    sign_in
    visit new_cohort_project_path(cohort)

    expect(page).to_not have_content("Title")
    expect(page).to have_content("You do not have permission to add projects")
  end

  scenario "student doesn't see button to add project" do
    set_omniauth
    sign_in
    visit new_cohort_project_path(cohort)
    save_and_open_page
  

    expect(page).to_not have_content("Create New Project")
    
  end
  


end
