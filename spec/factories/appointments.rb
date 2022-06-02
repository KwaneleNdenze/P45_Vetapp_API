FactoryBot.define do
  factory :appointment do
  
    vet_id { Faker::Number.number(10) }
    date { Faker::Date.between(from: '2022-06-01', to: '2022-12-01') }
  end
end