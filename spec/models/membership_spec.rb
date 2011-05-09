require 'spec_helper'

describe Membership do
  
  before(:each) do
		
		  @attr = {
		  		:name => "Membership Name",
		      :description => "The membership description",
		      :pool => true,
		      :tennis => true,
		      :sauna => true,
		      :guests => 1,
		      :fee => 19.99 }   
		end
		
		describe "validations" do
	
			it "should require a fee" do
				no_fee_membership = Membership.new(@attr.merge(:fee => nil))
				no_fee_membership.should_not be_valid
			end
					
			it "should create a new instance given valid attributes" do
				membership = Membership.new(@attr)
				membership.should be_valid	
			end	
					
			it "should reject invalid titles" do
				no_name_membership = Membership.new(@attr.merge(:name => ""))
				no_name_membership.should_not be_valid
			end
			
			it "should reject no description" do
				no_description_membership = Membership.new(@attr.merge(:description => ""))
				no_description_membership.should_not be_valid
			end
			
			it "should reject names that are too short" do
				short_name_membership = Membership.new(@attr.merge(:name => "hi"))
				short_name_membership.should_not be_valid
			end
			
			it "should reject names that are too long" do
				long_name = "a" * 151
				long_name_membership = Membership.new(@attr.merge(:name => long_name))
				long_name_membership.should_not be_valid
			end
			
			it "should reject too many guests" do
				long_guests = 31
				too_many_membership = Membership.new(@attr.merge(:guests => long_guests))
				too_many_membership.should_not be_valid
			end
			
			it "should allow no guests" do
				membership = Membership.new(@attr.merge(:guests => 0))
				membership.should be_valid
			end
				
	end

  
  
end
