class UsersController < ApplicationController

  def index
    @users = User.all
    message = {'usuarios' => @users, 'total' => @users.count}.to_json
    render json: message, status: :ok
  end

  def show
    @user = User.find(params[:id])
    if @user != nil
      render jason: @user, status: :ok
    else
      message = {'error' => 'Usuario no encontrado'}.to_json
      render json: message, status: :not_found
    end
  end

  def destroy
    if @user != nil
      @user.destroy
      head :no_content
    else
      message = {'error' => 'Usuario no encontrado'}.to_json
      render json: message, status: :not_found
    end
  end

  def update
    if @user != nil
      if @user.update(user_params)
        render jason: @user, status: :ok
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      message = {'error' => 'Usuario no encontrado'}.to_json
      render json: message, status: :not_found
    end
  end

  def create
    @user = User.new(user_params)

    if params[:id].present?
      message = {'error' => 'No se puede crear usuario con id'}.to_json
      render json: message, status: :bad_request
    else

      if @user.save
        render json: @user, status: :created
      else
        message = {'error' => 'La creación ha fallado'}.to_json
        render json: message, status: :bad_request
      end
    end
  end

  def user_params
    params.require(:user).permit(:usuario, :nombre, :apellido, :twitter)
  end

end
