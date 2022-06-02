FactoryBot.define do
  factory :pet do
    name { Faker::Lorem.word }
    pet_type { Faker::Creature::Animal.name }
  end
end