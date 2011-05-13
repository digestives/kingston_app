class ActivitiesController < ApplicationController

  def index
		@activities = Activity.all
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

  def destroy
    @activity = Activity.find(params[:id])

    if @activity.users.empty?
      flash[:notice] = "no users have booked this activity"
    else
      flash[:notice] = "You can not delete an activity which has been booked"
    end

    redirect_to activities_path

  end

end

