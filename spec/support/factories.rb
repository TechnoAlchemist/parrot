FactoryGirl.define do
  factory :user do
    first_name "Jane"
    last_name "Doe"
    email "user@example.com"
    role "Admin"
    cohort_id 3
  end

  factory :cohort do
    term "Fall"
  end

  factory :project do
    title "Hangman"
    cohort_id 3
    link "www.fakewebsite.com"
  end
end
