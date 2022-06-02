class UsersController < ApplicationController
  skip_before_action :authorize_request, only: [:create, :index, :destroy]

  def index
    # get current user pets
    @users = User.all
    json_response(@users)
  end

  # POST /signup
  # return authenticated token upon signup
  def create    
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password, user.role).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
    head :no_content
  end


  private

  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :role
    )
  end
end