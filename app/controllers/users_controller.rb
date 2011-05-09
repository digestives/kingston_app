class UsersController < ApplicationController
  
  def index
  	@users = User.all
  	#@post = Post.new if signed_in_and_admin?
  end

  def show
  	@title = "Profile"
  	@user = User.find(params[:id])
  	@membership = @user.subscription.membership if @user.has_subscription?
  end

  def new
  	@title = "Sign up"
  	@user = User.new
  end
  
  def create
  	@user = User.new(params[:user])
  	
  	if @user.save
  		flash[:success] = "Account created."
  		redirect_to signin_path
  	else
  		@title = "Sign up"
  		@user.terms_of_service = 0
  		render 'new'		
  	end 	
  end

  def edit
  	@user = User.find(params[:id])
  end
  
  def update
  	@user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Account updated."
      redirect_to @user
    else
      @title = "Edit"
      render 'edit'
    end
  end
  
  #
  # http://guides.rubyonrails.org/association_basics.html#the-has_one-through-association
  #
  def purchase_membership
  
  	if !signed_in?
  		flash[:info] = render_to_string(:partial => "shared/membership_not_signed_in")
  		redirect_to signup_path
  		return
  	end
  
  	if current_user.has_subscription?
  		flash[:notice] = "You must cancel your current membership before purchasing another."
  		redirect_to current_user
  	else
			#current_user.membership << Membership.find_by_id(params[:purchase]) 	
			#match '/memberships/:id/purchase' => 'users#purchase', :as => :purchase
			membership = Membership.find_by_id(params[:id])		
			# MY GOD THIS IS STARTING TO GET CONFUSING
			current_user.create_subscription(:membership => membership)	
			flash[:success] = "Thank you for purchasing a membership."		
			redirect_to current_user
		end
  end
  
  def cancel_membership
  	if current_user.subscription.destroy
  		flash[:info] = "Your subscription has been cancelled."
  	else
  		flash[:error] = "Please contact customer support."
  	end
  	redirect_to current_user
  end
  
  def swimming_booking
  	activity = Activity.find(params[:id])
  	booking = Booking.create(:activity_id => activity.id)
  	current_user.bookings << booking
  	redirect_to users_path
  end
  
  def cancel_booking
  
  end
  
  
  

end
