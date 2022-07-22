class UsersController < ApplicationController
  before_action only: [:index, :new, :create] do
    set_account
    require_manager_user(@account)
  end
  before_action only: [:edit, :update, :destroy] do
    set_user
    require_manager_user(@account)
    if !current_user.owner && @user.owner?
      flash[:alert] = "Only the owner can modify this user."
      redirect_to root_path
    end
  end

  def index
  end

  def new 
    @user = @account.users.new
  end

  def edit
  end

  def create 
    @user = @account.users.build(user_params)
    if @user.valid?
      @user.save
      flash[:notice] = "User was successfully created. The new user must confirm their account to gain access"
      redirect_to account_users_path(@account)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User was successfully updated"
      redirect_to account_users_path(@account)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    flash[:notice] = "Need to write code to delete user here!"
    redirect_to account_users_path(@account)
  end 

  private

  def set_parents
    if @user.present?
      @account = Account.find(@user.account_id)
      # cookie_name = "story_#{@story.id}"
      # cookies[cookie_name] = @part.id
    else
      redirect_to root_path
    end
  end

  def set_user
    @user = User.find(params[:id])
    set_parents
  end

  def set_account
    @account = Account.find(params[:account_id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :manager, :owner, :enabled)
  end

end