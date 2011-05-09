class ActivitiesController < ApplicationController

  def index
		@activities = Activity.all
		@date = Date.today
	end
	
	def show
    @activity = Activity.find(params[:id])
    @title = @activity.id
  end

  def new
  	@activity = Activity.new
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

end
