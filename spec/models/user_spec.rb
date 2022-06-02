require 'rails_helper'

RSpec.describe User, type: :model do
  # ensure Todo model has a 1:m relationship with the Item model
  it { should have_many(:pets) }
  it { should have_many(:vet_registrations) }
  it { should have_many(:appointments) }

  # ensure name, email and password_digest, role are present before save
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:role) }
end
