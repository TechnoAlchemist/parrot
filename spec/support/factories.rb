FactoryGirl.define do
  factory :user do
    first_name "Mark"
    last_name "Smith"
    sequence(:email) {|n| "person#{n}@parrot.com"}
    sequence(:username) {|n| "person#{n}"}
    role "admin"
    cohort
  end
end

FactoryGirl.define do
  factory :cohort do
    term "Fall"
  end
end

FactoryGirl.define do
  factory :group do
    project
  end
end

FactoryGirl.define do
  factory :group_membership do
    user
    group
  end
end
FactoryGirl.define do
  factory :project do
    sequence(:title) {|n| "project#{n}"}
    link "apollo.launchacademy.com"
    cohort
  end
end
