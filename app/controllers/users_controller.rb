class UsersController < ApplicationController
  def index
    @users = Users.all
    render json: @users, status: :ok
  end
  def show
    render jason: @user
  end
  def destroy
    @user.destroy
    head :no_content
  end
  def update
    if @user.update(contact_params)
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def create
    @user = Contact.new(contact_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

end
