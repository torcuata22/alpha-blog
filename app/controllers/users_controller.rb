class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def show
    @articles = @user.articles.paginate(:page => params[:page], :per_page => 5)
  end

  def index
    @users = User.paginate(:page => params[:page], :per_page => 5)

  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your account information has been updated"
      redirect_to @user 
    else       
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
        session[:user_id] = @user.id
        flash[:notice] = "Welcome to Freya's Blog #{@user.username}, you have successfully signed up."
        redirect_to  articles_path
    else       
        render 'new'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user #to prevent session's user id to be set to the id of a deleted user we set it to nil, to avoid admin being logged out, we added if.
    flash[:notice] = "Account and all associated articles successfully deleted"
    redirect_to users_path
  end

  def admin?
    self.admin
  end
  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])

  end
  
  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own account"
      redirect_to @user
    end
  end

end
