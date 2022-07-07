module ApplicationHelper

  def current_account
    if user_signed_in?
      current_user.account
    end
  end

  def current_account_manager?(account)
    user_signed_in? && current_user.manager? && current_user.account.id == account.id  
  end

end
