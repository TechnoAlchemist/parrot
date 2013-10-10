require 'spec_helper'

feature 'admin generates a spec', %Q{
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

  scenario 'cohort has students, user is admin' do
    5.times { FactoryGirl.create(:user) }
    admin = FactoryGirl.create(:user, role: 'admin')
    cohort = FactoryGirl.create(:cohort)
    project = FactoryGirl.create(:project, cohort_id: cohort.id)
    sign_in_as(admin)

    visit cohort_project_path(cohort, project)
    fill_in 'Group Size', with: 2
    click_on 'Generate Pairs'
    expect(Group.where(project_id: project.id).length).to eql(2)
  end
end
