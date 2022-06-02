class VetRegistrationsController < ApplicationController
  before_action :set_vet_registration, only: [:show, :update, :destroy]

  # GET /vet_registrations
  def index
    @vet_registrations = current_user.vet_registrations
    json_response(@vet_registrations)
  end

  def vet_index
    @vet_registrations = VetRegistration.all
    json_response(@vet_registrations)
  end
  # POST /vet_registrations
  def create
    @vet_registration = current_user.vet_registrations.create!(vet_registration_params)
    json_response(@vet_registration, :created)
  end

  # GET /vet_registration/:id
  def show
    json_response(@vet_registration)
  end

  # PUT /vet_registrations/:id
  def update
    @vet_registration.update(vet_registration_params)
    head :no_content
  end

  # DELETE /vet_registrations/:id
  def destroy
    @vet_registration.destroy
    head :no_content
  end

  private

  def vet_registration_params
    # whitelist params
    params.permit(:pet_id, :vet_id, :user_id)
  end

  def set_vet_registration
    @vet_registration = VetRegistration.find(params[:id])
  end
end