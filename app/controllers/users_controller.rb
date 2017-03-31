class UsersController < ApplicationController

  def index
    @users = User.all
    message = {'usuarios' => @users, 'total' => @users.count}.to_json
    render json: message, status: :ok
  end

  def show
    if User.exists?(params[:id])
      render json: User.find(params[:id]), status: :ok
    else
      message = {'error' => 'Usuario no encontrado'}.to_json
      render json: message, status: :not_found
    end
  end

  def destroy
    if User.exists?(params[:id])
      User.find(params[:id]).destroy
    else
      message = {'error' => 'Usuario no encontrado'}.to_json
      render json: message, status: :not_found
    end
  end

  def update
    if user_params[:id].present?
      message = {'error' => 'id no es modificable'}.to_json
      render json: message, status: :bad_request
    else
      if User.exists?(params[:id])
        @user = User.find(params[:id])
        if @user.update(user_params)
          render json: @user, status: :ok
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      else
        message = {'error' => 'Usuario no encontrado'}.to_json
        render json: message, status: :not_found
      end
    end
  end

  def create
    @user = User.new(user_params)

    if params[:id].present?
      render json: {error: "No se puede crear usuario con id"}, status: :bad_request
    else

      if @user.save
        render json: @user, status: :created
      else
        render json: {error: "La creación ha fallado"}, status: :bad_request
      end
    end
  end

  def user_params
    params.permit(:user, :usuario, :nombre, :apellido, :twitter)
  end

end
