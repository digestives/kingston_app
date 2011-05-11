# == Schema Information
# Schema version: 20110507183134
#
# Table name: memberships
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  fee         :decimal(, )
#  created_at  :datetime
#  updated_at  :datetime
#  pool        :boolean
#  sauna       :boolean
#  tennis      :boolean
#  guests      :integer
#

class Membership < ActiveRecord::Base

  default_scope :order => 'memberships.created_at DESC'

	NUM_GUESTS_ALLOWED = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]

  attr_accessible :pool, :sauna, :tennis, :name, :description, :fee, :guests

	has_many :users, :through => :subscriptions

	validates :name, :presence => true, :length => { :within => 3..150 }

	validates :description, :presence => true

  validates :pool, :inclusion => { :in => [true], :message => "must be granted if tennis or sauna is not" }, :if => lambda { |m| !m.tennis && !m.sauna }

	validates :fee, :presence => true

	validates :guests, :allow_blank => true, :numericality => true, :inclusion => { :in => 0..30 }

end

