FactoryGirl.define do
  factory :user do
    provider 'github'
    uid '123545'
    first_name "Mark"
    last_name "Smith"
    sequence(:email) {|n| "person#{n}@parrot.com"}
    sequence(:username) {|n| "person#{n}"}
    role "admin"
    cohort
  end

  factory :cohort do
    term "Fall"
  end

  factory :group do
    project
  end

  factory :group_membership do
    user
    group
  end

  factory :project do
    sequence(:title) {|n| "project#{n}"}
    link "apollo.launchacademy.com"
    cohort
  end
end
