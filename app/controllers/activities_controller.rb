class ActivitiesController < ApplicationController

  def new
  	@activity = Activity.new
  	
  	@date = Date.today
  end
  
  def create
  	@activity = Activity.new(params[:activity])
  	if @activity.save
  		flash[:notice] = "Activity has been added"
  		redirect_to activities_path
  	else
  		@title = "New Activity"
  		render 'new'
  	end	
	end
	
	def show
		@activity = Activity.find(params[:id])
		@title = @activity.id
	end
	
	def index
		@activities = Activity.all
		@date = Date.today
	end

end
