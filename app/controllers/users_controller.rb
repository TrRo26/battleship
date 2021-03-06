class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :show, :destroy]

  def show
    if session[:user_id] != params[:id].to_i
      redirect_to new_session_path
    end
    @game = Game.new
  end

  def new
    @user = User.new
  end

  def edit
    if session[:user_id] != params[:id].to_i
      redirect_to new_session_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      render :new
    end
  end

  def update
    if session[:user_id] != params[:id].to_i
      redirect_to new_session_path
    else
      if @user.update_attributes(user_params)
        redirect_to @user
      else
        render :edit
      end
    end
  end

  def destroy
    if session[:user_id] != params[:id].to_i
      redirect_to new_session_path
    else
      if @user.destroy
        session[:user_id] = nil
        redirect_to root_path
      end
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def find_user
      @user = User.find(params[:id])
    end
end

