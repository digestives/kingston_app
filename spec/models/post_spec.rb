require 'spec_helper'

describe Post do
  
  before(:each) do
  
  		@user = Factory(:user)		
		  @attr = {
		  		:title => "Welcome!",
		  		:content => "Welcome to Kingston Leisure!\n" << "\nThis is a news posting!",
		  		:published => "1" }		  			  	  		
	end

	describe "validations" do
	
			it "should require a user id" do
				no_id_post = Post.new(@attr)
				no_id_post.should_not be_valid
			end
					
			it "should create a new instance given valid attributes" do
				post = @user.posts.build(@attr)
				post.should be_valid	
			end	
					
			it "should reject invalid titles" do
				no_title_post = @user.posts.build(@attr.merge(:title => ""))
				no_title_post.should_not be_valid
			end
			
			it "should reject titles that are too short" do
				short_title_post = @user.posts.build(@attr.merge(:title => "hi"))
				short_title_post.should_not be_valid
			end
			
			it "should reject titles that are too long" do
				long_title = "a" * 101
				short_title_post = @user.posts.build(@attr.merge(:title => long_title))
				short_title_post.should_not be_valid
			end
				
	end
		
  
end
