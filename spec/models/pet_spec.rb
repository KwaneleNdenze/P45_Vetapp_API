require 'rails_helper'

RSpec.describe Pet, type: :model do
  # Association test
  # ensure a pet record belongs to a single user
  it { should belong_to(:user) }
  it { should have_many(:vet_registrations) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:pet_type) }

end
