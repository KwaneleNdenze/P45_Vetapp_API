class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :pet

   # validations
   validates_presence_of :vet_id, :pet_id, :date
end
