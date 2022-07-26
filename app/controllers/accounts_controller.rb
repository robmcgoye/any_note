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
    @account = Account.new(new_account_params)
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
    respond_to do |format|
      if @account.update(update_account_params)
        format.html { redirect_to account_path(@account), notice: "Account was successfully updated." }
        # format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @owner = @account.registered_owner
  end

  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to destroy_user_session_path, notice: "Account was successfully closed. All data/users has been removed" }
      format.json { head :no_content }
    end
  end

  private

    def set_account
      @account = Account.find_by id: params[:id]
    end

    def new_account_params
      params.require(:account).permit(:name, 
        users_attributes: [:id, :first_name, :last_name, :email, :owner, :password, :password_confirmation, :_destroy])
    end

    def update_account_params
      params.require(:account).permit(:name)
    end


end