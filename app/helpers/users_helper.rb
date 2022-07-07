module UsersHelper

    def get_user_formatting (user)
      if user.enabled? && user != current_user
        "fw-normal"
      elsif user.enabled? && user == current_user
        "fw-bold"
      else
        "fst-italic"
      end
    end
end
