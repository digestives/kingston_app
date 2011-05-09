
Factory.define :user do |user|

	user.organisation					 "Kingston University"
  user.forename              "David"
  user.surname							 "Haskins"
  user.address							 "Kingston University\nKingston Upon Thames\nSurrey"
  user.post_code						 "KT1 2EE"
  user.telephone						 "020 8417 9000"
  user.email                 "david.haskins@example.com"
  user.password              "password"
  user.password_confirmation "password"
  user.admin								 false
  
end

Factory.define :membership do |membership|

	membership.name					 	 "Kingston University Membership"
  membership.description     "A membership for Kingston University Students"
  membership.pool						 true
  membership.tennis					 false
  membership.sauna					 true
  membership.guests					 2
  membership.fee						 29.99
  
end
