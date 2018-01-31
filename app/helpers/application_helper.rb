module ApplicationHelper

	def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def allowed?(level:, user: current_user, id: 0)
  	#Level represents authorization needed
  	case level
  	when 1 #Requires login
  		return true if current_user
  	when 1.5 #Requires user id matching the id value, or moderator
  		return true if user.id == id or user.moderator?
  	when 2 #Requires moderator
  		return true if user.moderator?
  	end
  	#If none of the above
  	return false
  end

  def flash_class(level)
    case level
      when 'notice' then return "alert alert-info"
      when 'success' then return "alert alert-success"
      when 'error' then return "alert alert-danger"
      when 'alert' then return "alert alert-warning"
    end
  end

end
