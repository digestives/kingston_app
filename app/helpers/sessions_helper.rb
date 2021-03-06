module SessionsHelper

	def sign_in(user)
		session[:user_id] = user.id
		self.current_user = user
	end

	def sign_out
		session[:user_id] = nil
		self.current_user = nil
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user?(user)
    current_user == user
  end

	def current_user
		@current_user ||= User.find_by_id(session[:user_id])
	end

	def signed_in?
	  !current_user.nil?
	end

	def signed_in_and_admin?
		!current_user.nil? && current_user.admin
	end

	def deny_access
	  flash[:notice] = "Please sign in."
    redirect_to signin_path
  end

end

