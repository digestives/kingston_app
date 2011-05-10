require 'spec_helper'

describe SessionsController do
	render_views

  describe "GET 'new'" do

		it "should be successful" do
		  get 'new'
		  response.should be_success
		end

		it "should have the right title" do
		  get 'new'
		  response.should have_selector("title", :content => "Kingston Leisure | Sign up")
		end

		it "should have an email field" do
		  get 'new'
		  response.should have_selector("input[name='session[email]'][type='text']")
		end

		it "should have a password field" do
		  get 'new'
			response.should have_selector("input[name='session[password]'][type='password']")
		end

  end

  describe "POST 'create'" do

  	describe "sign in failure" do

  	  before(:each) do
  	    @attr = { :email => "invalid@failure.com", :password => "invalid" }
  	  end

  	  it "should render the 'new' page" do
  	    post :create, :session => @attr
  	    response.should render_template('new')
  	  end

  	  it "should have the right title" do
  	    post :create, :session => @attr
  	    response.should have_selector("title", :content => "Kingston Leisure | Sign up")
  	   end

				it "should have a flash error message" do
				  post :create, :session => @attr
				  flash.now[:error].should contain("Invalid email/password combination")
				end

		end

		describe "sign in success" do

		  before(:each) do
		    @user = Factory(:user)
		    @attr = { :email => @user.email, :password => @user.password }
		  end

		  it "should sign the right user in" do
		    post :create, :session => @attr
		    controller.current_user.should == @user
		  end

		  it "should redirect to the user 'show' page" do
		    post :create, :session => @attr
		    response.should redirect_to(user_path(@user))
		  end
		end

  end

end

