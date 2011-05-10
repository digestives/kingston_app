require 'spec_helper'

describe MembershipsController do
	render_views

  describe "GET 'new'" do

    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have a title" do
    	get 'new'
    	response.should have_selector("title", :content => "Kingston Leisure | Create Membership")
    end

  end

  describe "POST 'create'" do

		describe "success" do

  		before(:each) do
  		  @attr = {
			  	:name => "membership name",
		      :description => "memmbership description",
		      :pool => true,
		      :sauna => true,
		      :tennis => true,
		      :guests => 5,
		      :fee => 19.99 }
  		end

  		it "should create a membership" do
				  lambda do
				    post :create, :membership => @attr
				  end.should change(Membership, :count).by(1)
      end

      it "should redirect to the memberships page" do
				  post :create, :membership => @attr
				  response.should redirect_to(memberships_path)
      end

      it "should have a flash message" do
      		post :create, :membership => @attr
      		flash[:success].should contain("Memembership created!")
      end

  	end

  	describe "failure" do

  	  before(:each) do
  	    @attr = { :name => "", :description => "", :pool => true, :sauna => true, :tennis => true, :guests => 0, :fee => 19.99 }
  	  end

  	  it "should not create a membership" do
  	    lambda do
  	      post :create, :membership => @attr
  	    end.should_not change(Membership, :count)
		  end

		  it "should render the 'new' page" do
				post :create, :membership => @attr
				response.should render_template('new')
		  end
    end

	end


end

