require 'spec_helper'

feature 'admin generates a spec', %Q{
As a Launch Academy Student
I want to see who I am paired with
So I can schedule times to work with them
} do

# Acceptance Criteria:
# * Under each project, I see the list of pair/group assignments

  scenario '' do
    student1 = FactoryGirl.create(:user)
    student2 = FactoryGirl.create(:user)
    cohort = FactoryGirl.create(:cohort)
    cohort.students.push(student1, student2)
    project = FactoryGirl.create(:project, cohort_id: cohort.id)
    group = FactoryGirl.create(:group, project_id: project.id)
    GroupMembership.create(user_id: student1.id, group_id: group.id)
    GroupMembership.create(user_id: student2.id, group_id: group.id)
    sign_in_as(student)

    visit cohort_project_path(cohort, project)
  end
end
