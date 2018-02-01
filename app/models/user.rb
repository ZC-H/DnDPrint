class User < ApplicationRecord
	validates :email, presence: true
	validates :email,	:format => { :with => /.+@.+\..+.+/,
    :message => "Invalid email format." }
  validates :email, uniqueness: true
  has_secure_password
  validates :password, confirmation: true, :unless => Proc.new { |user| user.password_digest }
	validates :password_confirmation, presence: true, :unless => Proc.new { |user| user.password_digest }
	enum role: [:standard,:moderator,:admin]
	has_many	:sheets, dependent: :destroy
	before_create { generate_auth_token }

	def generate_auth_token
		self.auth_token = SecureRandom.urlsafe_base64
	end

	def self.login(params)
		user = User.find_by(email: params['email'])
		return nil if !user or user.password_digest == nil
		if user && user.authenticate(params['password'])
			return user
		else
			return nil
		end
	end

	def self.googleaccount(auth)
		#Creates a google account if one doesn't exist, then logs in to that account
		params = auth.info
    user = User.find_by(email: params['email'])
    if !user
    	user = User.new
    	user.email = params['email']
    	user.name = params['name']
    	user.save(validate: false)
    end
    user
	end
end
