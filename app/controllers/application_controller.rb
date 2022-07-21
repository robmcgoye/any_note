class ApplicationController < ActionController::Base
  # before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :admin_user?, :manager_user?, :allowed_user?
  # before_action :configure_permitted_parameters, if: :devise_controller?
  include ApplicationHelper

  def admin_user?
    user_signed_in? && current_user.admin?
  end

  def manager_user?
    user_signed_in? && (current_user.owner? || (current_user.manager? && current_user.enabled?) )
  end

  def allowed_user?
    user_signed_in? && current_user.enabled?
  end

  def require_admin_user
    if !user_signed_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to user_session_path
    elsif !current_user.admin?
      flash[:alert] = "You must be an admin to perform that action"
      redirect_to root_path      
    end
  end

  def require_manager_user(account)
    if !user_signed_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to user_session_path
    elsif !manager_user? || !current_user.account.id == account.id
      if !current_user.enabled?
        flash[:alert] = "This user has been disabled contact the owner/manager to enable it."
      else
        flash[:alert] = "You must be a manager to perform that action"
      end
      redirect_to root_path
    end 
  end

  def require_owner_user(account)
    if !user_signed_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to user_session_path
    elsif !manager_user? || !current_user.account.id == account.id
      if !current_user.enabled?
        flash[:alert] = "This user has been disabled contact the owner/manager to enable it."
      else
        flash[:alert] = "You must be a manager to perform that action"
      end
      redirect_to root_path
    elsif !current_user.owner
      flash[:alert] = "You must be the owner to perform that action"
      redirect_to root_path
    end 
  end

  def require_allowed_user(account)
    if !user_signed_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to user_session_path
    elsif !allowed_user? || !current_user.account.id == account.id
      if !current_user.enabled?
        flash[:alert] = "This user has been disabled contact the owner/manager to enable it."
      else
        flash[:alert] = "You don't have a valid user account."
      end
      redirect_to root_path
    end 
  end

  protected

  def configure_permitted_parameters
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    # devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

end
