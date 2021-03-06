class UsersController < ApplicationController
  before_action :set_user, only: [:show,:edit,:update,:destroy]
  before_action :require_same_user, only:[:edit,:update,:destroy]

  def index 
    @users = User.paginate(page:params[:page], per_page:5)
  end

  def new 
    @user = User.new
  end

  def show
    @articles = @user.articles.paginate(page:params[:page], per_page:5)
  end 

  def create 
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome, #{@user.username}. You have successfuly loggin."
      redirect_to articles_path
    else
      render "new"
    end
  end

  def edit 
  end 

  def update
    if @user.update(user_params)
      flash[:notice] = "Yoour account information was successfully updated"
      redirect_to user_path(@user)
    else 
      render "edit"
    end 
  end 

  def destroy
    @user.destroy
    session[:user_id] = nil if current_user == @user
    flash[:notice] = "Account and associated articles have been delete."
    redirect_to root_path
  end 

  private
  def user_params
    params.require(:user).permit(:username,:email,:password)
  end

  def set_user
    @user =  User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit your own articles"
      redirect_to articles_path
    end
  end 

end