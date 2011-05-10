class SessionsController < ApplicationController

  def new
  	@title = "Sign up"
  end

  def create
		if user = User.authenticate(params[:session][:email], params[:session][:password])
			sign_in(user)
			redirect_to user_path(user)
		else
			flash.now[:error] = render_to_string(:partial => 'shared/invalid_sign_in')
			@title = "Sign up"
			render 'new'
		end
	end

	def destroy
		flash[:notice] = "#{current_user.forename} signed out."
		sign_out
		redirect_to root_path
	end

end

