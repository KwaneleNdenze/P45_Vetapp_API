require 'rails_helper'

RSpec.describe VetRegistration, type: :model do
  # Association test
  # ensure Todo model has a 1:m relationship with the Item model
  it { should belong_to(:user) }
  it { should belong_to(:pet) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:pet_id) }
  it { should validate_presence_of(:vet_id) }
end
