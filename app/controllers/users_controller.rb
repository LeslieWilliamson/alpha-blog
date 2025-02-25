class UsersController < ApplicationController
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
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
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
    @user = User.find(params[:id])
    @articles = @user.articles
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to @user
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
