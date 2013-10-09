require 'spec_helper'

feature "admin_views_a_cohort" do
  let(:user) {FactoryGirl.create(:user)}
  let(:cohorts) {FactoryGirl.create_list(:cohort, 3)}

  scenario "admin successfully views cohorts" do
    sign_in_as(user)
    visit cohorts_path

    expect(page).to have_content "Cohorts"
    expect(page).to have_content cohorts.first.term
    expect(page).to have_content cohorts.last.term
  end

  scenario "admin successfully views a cohort" do
    sign_in_as(user)
    visit cohorts_path
    click_link cohorts.first.term

    expect(page).to have_content cohorts.first.term
    expect(page).to have_content "Edit"
    expect(page).to have_content "Delete"
  end

  scenario "unauthenticated user sees cohort info, but not Edit and Delete links" do
    visit cohorts_path
    click_link cohorts.first.term

    expect(page).to have_content cohorts.first.term
    expect(page).to_not have_content "Edit"
    expect(page).to_not have_content "Delete"
  end
end
