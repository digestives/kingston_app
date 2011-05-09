require 'spec_helper'

describe Subscription do
  
  #
  # The subscription is created through the
  # user based on a membership
  #
  
  before(:each) do
    @membership = Factory(:membership)
    @user = Factory(:user)
  end
  
  describe "validations" do
  	
  	it "should create a subscription with valid attributes" do
			subscription = @user.build_subscription(:membership => @membership)
			subscription.should be_valid
  	end
  
		it "should require a membership id" do
			@membership.id = nil
			subscription = @user.build_subscription(:membership => @membership)
			subscription.should_not be_valid
		end
		
		it "should require a user id" do
			@user.id = nil
			subscription = @user.build_subscription(:membership => @membership)
			subscription.should_not be_valid
		end
			
  end
  
  
  
  
  
  
end
