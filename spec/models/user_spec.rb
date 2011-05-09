require 'spec_helper'

describe User do

		# before each test set the @attr
		# to the default so each test is 
		# under the same conditions
		
		before(:each) do
		
		  @attr = {
		  		:organisaton => "Organisation",
		      :forename => "Forename",
		      :surname => "Surname",
		      :email => "user@example.com",
		      :address => "Address Line 1\nAddress Line 2\n",
		      :post_code => "SM5 2HT",
		      :password => "password",
		      :password_confirmation => "password",
		      :telephone => "02086477030",
		      :terms_of_service => "1" }   
		end

		it "should create a new instance given valid attributes" do
		  User.create!(@attr)
		end
		
		it "should accept empty organisation" do
			no_organisation = User.new(@attr.merge(:organisaton => ""))
			no_organisation.should be_valid
		end

		it "should require a forename" do
		  no_name_user = User.new(@attr.merge(:forename => ""))
		  no_name_user.should_not be_valid
		end
		
		it "should require a surname" do
			no_name_user = User.new(@attr.merge(:surname => ""))
			no_name_user.should_not be_valid
		end

		it "should require an email" do
		  no_email_user = User.new(@attr.merge(:email => ""))
		  no_email_user.should_not be_valid
		end

		it "should reject names that are too long" do
		  long_name = "a" * 51
		  long_name_user = User.new(@attr.merge(:forename => long_name, :surname => long_name))
		  long_name_user.should_not be_valid
		end

		it "should reject names that are to short" do
		  short_name = "a"
		  short_name_user = User.new(@attr.merge(:forename => short_name, :surname => short_name))
		  short_name_user.should_not be_valid
		end

		it "should accept valid email addresses" do
		  addresses = ["user@kingston.com", "THE_USER@foo.bar.org", "first.last@example.co.uk"]
		  addresses.each do |address|
		    valid_email_user = User.new(@attr.merge(:email => address))
		    valid_email_user.should be_valid
		  end
		end

		it "should reject invalid email addresses" do
		  addresses = ["user@foo,com", "another_error.org", "example.user.foo.", "@co.uk"]
		  addresses.each do |address|
		    invalid_email_user = User.new(@attr.merge(:email => address))
		    invalid_email_user.should_not be_valid
		  end
		end

		it "should reject duplicate email addresses" do
		  User.create!(@attr)
		  user_with_duplicate_email = User.new(@attr)
		  user_with_duplicate_email.should_not be_valid
		end

		it "should reject email addresses identical to upper case" do
		  upper_cased_email = @attr[:email].upcase
		  User.create!(@attr.merge(:email => upper_cased_email))
		  user_with_duplicate_email = User.new(@attr)
		  user_with_duplicate_email.should_not be_valid
		end
		
		it "should reject email addresses identical to lower case" do
		  lower_cased_email = @attr[:email].downcase
		  User.create!(@attr.merge(:email => lower_cased_email))
		  user_with_duplicate_email = User.new(@attr)
		  user_with_duplicate_email.should_not be_valid
		end
		
		it "should reject invalid telephone numbers" do
			telephone_numbers = ["1608 123 456", "1608-123-456", "0000-0000-000", "0492", "not a number"]
			telephone_numbers.each do |number|
				invalid_telephone_user = User.new(@attr.merge(:telephone => number))
				invalid_telephone_user.should_not be_valid
			end
		end
			
		it "should accept valid telephone numbers" do
			telephone_numbers = ["02089935689", "020-8993-5689", "020 8993 5689"]
			telephone_numbers.each do |number|
				valid_telephone_user = User.new(@attr.merge(:telephone => number))
				valid_telephone_user.should be_valid
			end
		end
		
		it "should accept empty telephone numbers" do
			no_telephone_user = User.new(@attr.merge(:telephone => ""))
			no_telephone_user.should be_valid
		end
		
		it "should reject disagreed terms of service" do
			lambda do
				User.create!(@attr.merge(:terms_of_service => "0"))
			end.should raise_error(ActiveRecord::RecordInvalid)
		end
		
		it "should accept agreed terms of service" do
			lambda do
				accepted_terms_user = User.create!(@attr.merge(:terms_of_service => "1"))
				accepted_terms_user.should be_valid
			end.should_not raise_error(ActiveRecord::RecordInvalid)
		end	

		describe "password validations" do

				it "should require a password" do
				  no_password_user = User.new(@attr.merge(:password => "", :password_confirmation => ""))
				  no_password_user.should_not be_valid
				end

				it "should require a matching password confirmation" do
				  password_mismatch_user = User.new(@attr.merge(:password_confirmation => "invalid"))
				  password_mismatch_user.should_not be_valid
				end

				it "should reject short passwords" do
				  short = "a" * 3
				  hash = @attr.merge(:password => short, :password_confirmation => short)
				  User.new(hash).should_not be_valid
				end

				it "should reject long passwords" do
				  long = "a" * 31
				  hash = @attr.merge(:password => long, :password_confirmation => long)
				  User.new(hash).should_not be_valid
				end

		end # end password validations
		
		describe "encrypted password" do
		
				before(:each) do
					@user = User.create(@attr)
				end
			
				it "should have an encrypted password" do
					@user.should respond_to(:encrypted_password)
				end
			
				it "should set the encrypted_password" do
					@user.encrypted_password.should_not be_blank
				end 
				
		end
		
		describe "authentication" do
			
				it "should be nil on email/password mismatch" do
				  wrong_password_user = User.authenticate(@attr[:email], "not_the_password")
				  wrong_password_user.should be_nil
				end

				it "should be nil for an email address with no user" do
				  not_user = User.authenticate("another@example.com", @attr[:password])
				  not_user.should be_nil
				end

				it "should be the user on email and password match" do
				   matching_user = User.authenticate(@attr[:email], @attr[:password])
				   matching_user.should == @user
				end	
				
		end
  
end
