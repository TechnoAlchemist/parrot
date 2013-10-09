require 'spec_helper'

feature "admin_creates_a_cohort" do

  let(:user) {FactoryGirl.create(:user)}
  let(:cohort) {FactoryGirl.build(:cohort)}

  scenario "admin successfully creates cohort" do
    prev_count = Cohort.count
    sign_in_as(user)
    visit new_cohort_path
    fill_in "Term", with: cohort.term
    click_button "Create New Cohort"

    expect(page).to have_content "A new cohort has been created"
    expect(Cohort.count).to eql(prev_count + 1)
  end

  scenario "admin fails to create cohort" do
    prev_count = Cohort.count
    sign_in_as(user)
    visit new_cohort_path
    click_button "Create New Cohort"

    expect(page).to_not have_content "A new cohort has been created"
    expect(page).to have_content "can't be blank"
    expect(Cohort.count).to eql(prev_count)
  end
end



