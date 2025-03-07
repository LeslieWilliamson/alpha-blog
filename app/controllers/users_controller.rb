class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]
  before_action :require_user, only: [ :edit, :update ]
  before_action :require_same_user, only: [ :edit, :update, :destroy ]

  def new
    @user = User.new
  end

  def create
    # binding.break
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the Alpha Blog, #{@user.username}. You have successfully signed up."
      redirect_to user_path(@user)
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
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def show
     @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    self_destruct = (@user == current_user)

    @user.destroy
    flash[:notice] = "Account and all associated articles deleted"

    if self_destruct
      session[:user_id] = nil
      redirect_to signup_url
    else
      redirect_to users_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    begin
        @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    end
  end

  def require_same_user
    if !(current_user.admin? || current_user == @user)
      flash[:alert] = "You can only update or delete your own profile."
      redirect_to @user
    end
  end
end
