class AccountsController < ApplicationController
  before_action only: [:show] do
    set_account
    require_allowed_user(@account)
  end
  before_action only: [:edit, :update, :destroy] do
    set_account
    require_owner_user(@account)
  end

  def new
    @account = Account.new
    @account.users.new( owner: true )
  end

  def create
    binding.break
    @account = Account.new(account_params)
    if @account.save
      flash[:notice] = "Created account please confirm your account."
      redirect_to new_user_session_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    flash[:notice] = "Need to write code to update account!"
    redirect_to account_path(@account)
  end

  def show
    @owner = @account.registered_owner
  end

  def destroy
    flash[:notice] = "Need to write code to delete EVERYTHING here!"
    redirect_to root_path
  end

  private

    def set_account
      @account = Account.find(params[:id])
    end

    def account_params
      params.require(:account).permit(:name, 
        users_attributes: [:id, :first_name, :last_name, :email, :owner, :password, :password_confirmation, :_destroy])
    end

end