# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

		  Membership.create!(:name => "Pool",
												 :description => "Unlimited Pool",
												 :sauna => false,
												 :pool => true,
												 :tennis => false,
												 :guests => 0,
												 :fee => "4.99")

		  Membership.create!(:name => "Pool and Sauna",
												 :description => "Unlimited Pool with sauna",
												 :sauna => true,
												 :pool => true,
												 :tennis => false,
												 :guests => false,
												 :fee => "8.99")

		  Membership.create!(:name => "Silver",
												 :description => "Unlimited Pool with sauna and guest",
												 :sauna => true,
												 :pool => true,
												 :tennis => false,
												 :guests => 1,
												 :fee => "15.99")

			Membership.create!(:name => "Gold",
												 :description => "Unlimited Pool with sauna and tennis",
												 :sauna => true,
												 :pool => true,
												 :tennis => true,
												 :guests => false,
												 :fee => "19.99")

      Membership.create!(:name => "Platinum",
												 :description => "Unlimited Pool with sauna and tennis and guest",
												 :sauna => true,
												 :pool => true,
												 :tennis => true,
												 :guests => 2,
												 :fee => "25.99")

