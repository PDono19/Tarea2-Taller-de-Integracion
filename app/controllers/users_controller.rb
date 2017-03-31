class UsersController < ApplicationController

  def index
    @users = User.all
    message = {'usuarios' => @users, 'total' => @users.count}.to_json
    render json: message, status: :ok
  end

  def show
    @user = User.find(params[:id])
    if @user != nil
      render json: @user, status: :ok
    else
      render json: {error: "Usuario no encontrado"}, status: 404
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user != nil
      @user.destroy
    else
      render json: {error: "Usuario no encontrado"}, status: 404
    end
  end

  def update
    @user = User.find(params[:id])

    #if user_params[:id].present?
    #  render json: {error: "id no es modificable"}, status: 400
    #else
      if @user != nil
        if @user.update(user_params)
          render json: @user, status: :ok
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      else
        render json: {error: "Usuario no encontrado"}, status: 404
      end
    #end
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
