require 'spec_helper'

describe "Users" do
    
		describe "sign up" do
				
			describe "failure" do
					
				it "should not make a user" do	
				
					lambda do	
							visit signup_path
							fill_in "user[organisation]", :with => ""
							fill_in "user[forename]", 		:with => ""
							fill_in "user[surname]", 			:with => ""
				 			fill_in "user[email]",  			:with => "example@email.co.uk"				
							fill_in "user[address]", 			:with => ""
							fill_in "user[post_code]", 		:with => ""
							fill_in "user[telephone]", 		:with => ""
							fill_in "user[password]", 		:with => ""
							fill_in "user[password_confirmation]", :with => ""
							uncheck "user[terms_of_service]"
							click_button
							response.should render_template('users/new')
							response.should have_selector("div#error_explanation")
					end.should_not change(User, :count)
					
				end		
				
			end	# end failure
			
				describe "success" do
				
						it "should make a user" do
						
								lambda do	
										visit signup_path
										fill_in "user[organisation]", :with => "Kingston University"
										fill_in "user[forename]",			:with => "Patrick"
										fill_in "user[surname]",			:with => "Magee"
										fill_in "user[email]",				:with => "k0956921@kingston.ac.uk"
										fill_in "user[address]",			:with => "Penrhyn Road\n
																														Kingston upon Thames\n
																														Surrey"
																											
										fill_in "user[post_code]",		:with => "KT1 2EE"
										fill_in "user[telephone]", 		:with => "020 8417 9000"
										fill_in "user[password]", 		:with => "password"
										fill_in "user[password_confirmation]", :with => "password"
										check		"user[terms_of_service]"
										click_button
										response.should have_selector("div.success", :content => "Account created.")
										response.should render_template('sessions/new')						
							
								end.should change(User, :count).by(1)
								
						 end 		
				end # end success
			
		end # end signing up
		
end



