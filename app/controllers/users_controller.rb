class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]

  def new
    @user = User.new
  end

  def create
    # binding.break
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to the Alpha Blog, #{@user.username}"
      redirect_to users_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your account information was successfully updated"
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def index
    @users = User.all
  end

  def show
     @articles = @user.articles
  end

  def destroy
    @user.destroy
    redirect_to @user
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
