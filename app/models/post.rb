# == Schema Information
# Schema version: 20110506141129
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  content    :text
#  published  :boolean
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base

	# The last entry should come first
	default_scope :order => 'posts.created_at DESC'
	
	belongs_to :user
	
	validates :user_id, :presence => true
	
 validates :title,   :content, :presence => true
 
 validates :title,   :length => { :minimum => 3, 
 																                 :maximum => 100 }

	
end
