require 'faker'

namespace :db do

  desc "Fill database with sample data"

  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_admin
    make_users
    make_memberships
    make_posts
  end

  def make_admin
  	admin = User.create!(:organisation => "",
  										 	 :forename => "Patrick",
  										   :surname => "Magee",
                         :email => "k0956921@kingston.ac.uk",
                         :address => "12 Tyrell Court\nNorth Street\nCarshalton\nSurrey",
                         :post_code => "SM5 2HT",
                         :password => "password",
                         :password_confirmation => "password",
                         :terms_of_service => "1")
  	admin.toggle!(:admin)
  end

  def make_users

		50.times do |n|
		  forename  = Faker::Name.first_name
		  surname 	= Faker::Name.last_name
		  email     = Faker::Internet.email([forename, surname].join("."))
		  address   = [rand(300), Faker::Address.street_name].join(" ")
		  address   << "\n" << Faker::Address.city << "\n"
		  post_code = "SM5 2HT" # Cant find a decent generator for this...
		  terms_of_service = "1"
		  password  = "password"

		  User.create!(:organisation => "",
		  						 :forename => forename,
		  						 :surname => surname,
		               :email => email,
		               :address => address,
		               :post_code => post_code,
		               :password => password,
		               :password_confirmation => password,
		               :terms_of_service => terms_of_service)
		end
	end

	def make_posts
		user = User.first

		30.times do
			title = Faker::Company.catch_phrase
			body  = Faker::Lorem.paragraph(2)
			published = true

			user.posts.create!(:title => title, :content => body, :published => published)
		end

	end

	def make_memberships

		5.times do |n|

			name = Faker::Company.catch_phrase
			description = Faker::Lorem.paragraph(1)
			sauna = [true, false].rand
			pool = [true, false].rand
			tennis = [true, false].rand
			guests = rand(30)
			# Random number, then rounded with a precision of two from the decimal
			fee = (rand * 50).round(2)

			Membership.create!(:name => name,
												 :description => description,
												 :sauna => sauna,
												 :pool => pool,
												 :tennis => tennis,
												 :guests => guests,
												 :fee => fee)
		end
	end

end

