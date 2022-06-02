class VetRegistration < ApplicationRecord
  belongs_to :user
  belongs_to :pet

  validates_presence_of :vet_id, :pet_id, :user_id
end
