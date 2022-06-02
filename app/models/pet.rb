class Pet < ApplicationRecord
  belongs_to :user
  has_many :vet_registrations, dependent: :destroy
  has_many :appointments, dependent: :destroy
  # validations
  validates_presence_of :name, :pet_type
end
