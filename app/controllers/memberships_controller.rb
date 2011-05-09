class MembershipsController < ApplicationController
  
  def index
  	@title = "Memberships"
  	@memberships = Membership.all
  	@membership = Membership.new if signed_in_and_admin?
  end
  
  def new
  	@title = "Create Membership"
  	@membership = Membership.new
  end
  
  def show
  	@membership = Membership.find(params[:id])
  	@title = "Membership #{@membership.id}"
  end
  
  def create
  	@membership = Membership.new(params[:membership])
  	
  	if @membership.save
  		flash[:success] = "Memembership created!"
  		redirect_to memberships_path
  	else
  		@title = "Create Membership"
  		render 'new'
  	end
  end

end
