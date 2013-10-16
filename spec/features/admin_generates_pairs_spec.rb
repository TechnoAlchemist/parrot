require 'spec_helper'

feature 'admin generates pairs', %Q{
As an authenticated admin
I want to automatically generate pairing assignments
So that I can quickly assign pairs that aren't repeats.
} do

# Acceptance Criteria:
# * Admin must first be signed in as an admin
# * The groups must be have equal number of students (minus remainder students)
# * The pairing generator must account for remainder students
# * The pairing generator must keep track of pairs
# * Pairs should not repeat until every student has worked with every other student

  let!(:cohort) { FactoryGirl.create(:cohort) }

  scenario 'admin generates pairs' do
    FactoryGirl.create_list(:user, 4, cohort_id: cohort.id)
    project = FactoryGirl.create(:project, cohort_id: cohort.id)
    previous_count = Group.where(project_id: project.id).length
    set_omniauth(role: 'admin')
    sign_in

    visit cohort_project_path(cohort, project)
    fill_in 'Group Size', with: 2
    click_on 'Generate Pairs'
    expect(Group.where(project_id: project.id).length).to eql(previous_count + 2)
  end

  scenario 'odd numbered user is assigned to another group' do
    FactoryGirl.create_list(:user, 5, cohort_id: cohort.id)
    project = FactoryGirl.create(:project, cohort_id: cohort.id)
    previous_count = Group.where(project_id: project.id).length
    set_omniauth(role: 'admin')
    sign_in

    visit cohort_project_path(cohort, project)
    fill_in 'Group Size', with: 2
    click_on 'Generate Pairs'
    expect(Group.where(project_id: project.id).length).to eql(previous_count + 2)

    expect(Group.first.users.length).to eql(3)
  end

  scenario "student can't generate pairs" do
    project = FactoryGirl.create(:project, cohort_id: cohort.id)
    set_omniauth
    sign_in
    visit cohort_project_path(cohort, project)
    expect(page).to_not have_content 'Group Size'
    expect(page).to_not have_content 'Generate Pairs'
  end
end
