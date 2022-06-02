FactoryBot.define do
  factory :vet_registration do
    user_id { Faker::Number.number(10) }
    pet_id { Faker::Number.number(10) }
    vet_id { Faker::Number.number(10)}
  end
end