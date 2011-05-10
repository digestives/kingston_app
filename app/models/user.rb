# == Schema Information
# Schema version: 20110507233213
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  organisation       :string(255)
#  forename           :string(255)
#  surname            :string(255)
#  address            :text
#  post_code          :string(255)
#  telephone          :string(255)
#  email              :string(255)
#  encrypted_password :string(255)
#  salt               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  admin              :boolean
#  membership_id      :integer
#

require 'digest/sha2'

class User < ActiveRecord::Base

	has_many :posts
	has_many :bookings

	# http://guides.rubyonrails.org/association_basics.html#the-has_one-through-association

	#Because it goes through the subscription
	has_one :subscription
	has_one :membership, :through => :subscription

  # http://www.regxlib.com/Default.aspx

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  POST_CODE_REGEX = /^([A-PR-UWYZ]([0-9]{1,2}|([A-HK-Y][0-9]|[A-HK-Y][0-9]
		([0-9]|[ABEHMNPRV-Y]))|[0-9][A-HJKS-UW])\ [0-9][ABD-HJLNP-UW-Z]{2}|
		(GIR\ 0AA)|(SAN\ TA1)|(BFPO\ (C\/O\ )?[0-9]{1,4})|((ASCN|BBND|[BFS]
		IQQ|PCRN|STHL|TDCU|TKCA)\ 1ZZ))$/

  PHONE_REGEX = /(\s*\(?0\d{4}\)?(\s*|-)\d{3}(\s*|-)\d{3}\s*)|(\s*\(?0\d{3}\)?(\s*|-)\d
 							{3}(\s*|-)\d{4}\s*)|(\s*(7|8)(\d{7}|\d{3}(\-|\s{1})\d{4})\s*)/

  # virtual password attribute, virtual terms_of_service for sign up
  attr_accessor :password, :terms_of_service

  # a type of setters and getters, also enforces against PUT requests
  # for attributes not declared here, ie encrypted_password, salt
  attr_accessible :organisation, :forename, :surname,
  :password, :password_confirmation, :address,
  :email, :post_code, :terms_of_service, :telephone

 validates :organisation, :allow_blank => true, :length => { :within => 4..40 }

 validates :forename, :surname, :allow_blank => false, :length => { :within => 2..15 }

 validates :terms_of_service, :acceptance => true

 validates :password, :presence => true,
  :confirmation => true,
  :length => { :within => 5..30 },
  :if => :password_required?

 validates :address, :presence => true,
                     :length => { :minimum => 5 }

 validates :email, :uniqueness => { :case_sensitive => false },
  :format => { :with => EMAIL_REGEX , :message => "is not a valid email address" }

 validates :post_code, :allow_blank => false,
  :format => { :with => POST_CODE_REGEX, :message => "is not a valid uk post code" }

 validates :telephone, :allow_blank => true,
  :format => { :with => PHONE_REGEX, :message => "is not a valid uk number" }

  # Password is a virtual attribute, when this is passed through,
  # before saving the user we must encrypt the virtual attribute
  # and save it as the encrypted_password in the db

	before_save :encrypt_password
	before_update :password_required?

	def full_name
		[forename, surname].join(' ')
	end

	def has_password?(submitted_password)
		self.encrypted_password == encrypt(submitted_password)
	end

	def has_subscription?
    Subscription.exists?(['user_id = ?', id])
	end

	def can_book?
	 has_subscription? ? subscription.membership.pool? : false
	end

	# email and password used
	# to check if the user exists
	# and return the user
	def self.authenticate(email, submitted_password)
		if user = find_by_email(email)
			if user.has_password?(submitted_password)
				return user
			end
		end
	end

	private

	def password_required?
		self.encrypted_password.blank? || !password.blank?
	end

	def encrypt_password

		if new_record?
			self.salt = make_salt
		end
		self.encrypted_password = encrypt(password) # the virtual attribute

	end

	def make_salt
		Digest::SHA2.hexdigest("#{Time.now.utc}--#{rand}")
	end

	def encrypt(string)
		Digest::SHA2.hexdigest("#{self.salt}--#{string}")
	end

end

