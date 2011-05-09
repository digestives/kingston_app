require 'spec_helper'

describe UsersController do
	render_views
	
		before(:each) do
				@user = Factory(:user)
		end

  	describe "GET 'index'" do
  
			it "should be successful" do
				get 'index'
				response.should be_success
			end
  	end

  	describe "GET 'show'" do
  
			it "should be successful" do
				get 'show', :id => @user.id
				response.should be_success
			end
				 
			it "should include the users name" do
				get 'show', :id => @user.id
				response.should have_selector("h1",:content => @user.full_name)
			end
		
			it "should include the users email" do
				get 'show', :id => @user.id
				response.should have_selector("input[name='user[email]'][value='#{@user.email}']")
			end
			
  	end
  
  	describe "GET 'new'" do
  
			it "should be successful" do
				get 'new'
				response.should be_success
			end
		
			it "should have the right title" do
				get 'new'
				response.should have_selector("title",:content => "Kingston Leisure | Sign up")
			end
		
			it "should have a forename field" do
				get 'new'
				response.should have_selector("input[name='user[forename]'][type='text']")
			end
		
			it "should have a surname field" do
				get 'new'
				response.should have_selector("input[name='user[surname]'][type='text']")
			end
		
			it "should have an email field" do
				get 'new'
				response.should have_selector("input[name='user[email]'][type='text']")
			end
		
			it "should have an address field" do
				get 'new'
				response.should have_selector("textarea[name='user[address]']")
			end
		
			it "should have a telephone field" do
				get 'new'
				response.should have_selector("input[name='user[telephone]'][type='text']")
			end
		
			it "should have a password field" do
				get 'new'
				response.should have_selector("input[name='user[password]'][type='password']")
			end
		
			it "should have a password confirmation field" do
				get 'new'
				response.should have_selector("input[name='user[password_confirmation]'][type='password']")
			end
		
			it "should have a Terms of service checkbox" do
				get 'new'
				response.should have_selector("input[name='user[terms_of_service]'][type='checkbox']")
			end 
         
  	end # end GET new

	describe "GET 'edit'" do
	
		it "should be successful" do
		  get 'edit', :id => @user.id
		  response.should be_success
		end
		 
	end # end GET edit
  
  
  describe "POST 'create'" do
  	
  	describe "account failure" do
  		
  		before(:each) do
  		  @attr = { 
			  :organisaton => "",
		      :forename => "",
		      :surname => "",
		      :email => "",
		      :address => "",
		      :post_code => "",
		      :password => "",
		      :password_confirmation => "",
		      :telephone => "",
		      :terms_of_service => "1" }
  		end
  		
  		it "should not create a user" do
				  lambda do
				    post :create, :user => @attr
				  end.should_not change(User, :count)
      	end	
      	
      	it "should have the right title" do
				  post :create, :user => @attr
				  response.should have_selector("title", :content => "Kingston Leisure | Sign up")
      	end
      	
      	it "should render the 'new' page" do
				  post :create, :user => @attr
				  response.should render_template('new')
      	end
      	   	  		
  	end
  	
  	describe "account success" do
  	
  		  before(:each) do
				  @attr = { 
						:organisaton => "Organization",
				    :forename => "Forename",
				    :surname => "Surname",
				    :email => "forename.surname@example.com",
				    :address => "The Address\nWith another line",
				    :post_code => "KT5 8EE",
				    :password => "password",
				    :password_confirmation => "password",
				    :telephone => "",
				    :terms_of_service => "1" }
  			end
  		
  		it "should create a user" do
				lambda do
				    post :create, :user => @attr
				end.should change(User, :count).by(1)
      end
      
      it "should redirect to the 'sign in' page" do
				 post :create, :user => @attr
				 response.should redirect_to signin_path
      end
       			
  	end		
  end # end POST create

end
