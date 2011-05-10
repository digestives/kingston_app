require 'spec_helper'

describe PostsController do
	render_views

  describe "GET 'new'" do

    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have a title" do
    	get 'new'
    	response.should have_selector("title", :content => "Kingston Leisure | New Post");
    end

  end

  describe "POST 'create'" do

		before(:each) do
      @user = test_sign_in(Factory(:user))
    end

		describe "success" do

  		before(:each) do
  		  @attr = { :title => "title", :content => "the content", :published => "1" }
  		end

  		it "should create a post" do
				lambda do
				  post :create, :post => @attr
				end.should change(Post, :count).by(1)
      end

      it "should redirect to the home page" do
				post :create, :post => @attr
				response.should redirect_to(root_path)
      end

      it "should have a flash message" do
        post :create, :post => @attr
        flash[:success].should contain("Post created")
      end

  	end

  	describe "failure" do

  	  before(:each) do
				  @attr = { :title => "", :content => "", :published => "1" }
		  end

		  it "should not create a post" do
		    lambda do
		      post :create, :post => @attr
		    end.should_not change(Post, :count)
		  end

		  it "should render the 'new' page" do
				post :create, :post => @attr
				response.should render_template('new')
		  end

  	end
	end

end

