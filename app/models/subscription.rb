# == Schema Information
# Schema version: 20110506232113
#
# Table name: subscriptions
#
#  id            :integer         not null, primary key
#  membership_id :integer
#  user_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Subscription < ActiveRecord::Base

	# http://guides.rubyonrails.org/association_basics.html#the-has_one-through-association

	belongs_to :user
	belongs_to :membership
	
	validates :user_id, :presence => true
	validates :membership_id, :presence => true

end
