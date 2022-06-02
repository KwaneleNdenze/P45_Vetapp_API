require 'rails_helper'

RSpec.describe Appointment, type: :model do
  # Association test

  it { should belong_to(:user) }
  it { should belong_to(:pet) }
  # Validation tests
  
  # ensure columns vet_id, pet_id, and date are present before saving
  it { should validate_presence_of(:vet_id) }
  it { should validate_presence_of(:pet_id) }
  it { should validate_presence_of(:date) }
end
