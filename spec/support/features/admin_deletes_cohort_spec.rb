require 'spec_helper'

feature "admin_deletes_a_cohort" do

  let(:user) {FactoryGirl.create(:user)}
  let(:cohort) {FactoryGirl.create(:cohort)}

  scenario "admin successfully deletes cohort" do
    prev_count = Cohort.count
    sign_in_as(user)
    visit cohorts_path
    click_link cohort.term
    click_link "Delete"

    expect(Cohort.count).to eql(prev_count - 1)
    expect(page).to_not have_content cohort.term
  end

  scenario "unauthenticated user can not delete cohort" do
    visit cohorts_path
    click_link cohort.term

    expect(page).to_not have_content "Delete"
  end
end
