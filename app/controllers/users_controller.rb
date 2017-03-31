class UsersController < ApplicationController

  require 'json'

  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all
    json_response({:usuarios => @users, :total => @users.count})
  end

  # PUT /users
  def create

    begin

      if params.has_key?(:id)
          json_response({ :error => "No se puede crear usuario con id" }, 400)
      else
        @user = User.create!(user_params)
        json_response(@user, :created)
      end
    rescue
        json_response({ :error => "La creación ha fallado" }, 500)
    end
  end

  # POST /users/:id
  def update
    
    begin

      @keys =  (JSON.parse request.body.read).keys
      if @keys.include?("id")
          json_response({ :error => "id no es modificable" }, 400)
      else
        @user.update(user_params)
        json_response(@user, 200)
      end

    rescue
        json_response({ :error => "La modificación ha fallado" }, 500)
    end

  end

  # GET /users/:id
  def show
      json_response(@user)
  end

  # DELETE /users/:id
  def destroy
      @user.destroy
      head :no_content
  end

  private

  def user_params
    # whitelist params
    params.permit(:usuario, :nombre, :apellido, :twitter)
  end

  def set_user
    if User.exists?(id: params[:id])
      @user = User.find(params[:id])
    else
      json_response({ :error => "Usuario no encontrado" }, 404)
    end
  end
end