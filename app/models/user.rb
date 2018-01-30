class User < ApplicationRecord
	validates :email,	:format => { :with => /.+@.+\..+.+/,
    :message => "Invalid email format." }
  validates :email, uniqueness: { message: 'An account with that email already exists.'}
  has_secure_password
  validates :password, confirmation: { message: 'The two passwords do not match.'}
	validates :password_confirmation, presence: { message: 'Please confirm password.'}
	#devise :omniauthable, omniauth_providers: [:google_oauth2]

	def self.login(params)
		user = User.find_by(email: params['email'])
		return nil if user.password_digest == nil
		if user && user.authenticate(params['password'])
			return user.id
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
    user.id
	end
end
