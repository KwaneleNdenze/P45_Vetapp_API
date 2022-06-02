class User < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :vet_registrations, dependent: :destroy
  has_many :appointments, dependent: :destroy
  # encrypt password
  has_secure_password

  # validations
  validates_presence_of :name, :email, :password_digest, :role

end
