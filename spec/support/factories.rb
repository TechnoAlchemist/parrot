FactoryGirl.define do
  factory :user do
    first_name 'Pairing'
    last_name 'Parrot'
    email 'parrot@saltines.com'
    username 'parrot11'
    role 'admin'
    provider 'github'
    uid '3886085'
  end
end
