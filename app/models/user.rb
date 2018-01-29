class User < ApplicationRecord
	validates :email,	:format => { :with => /.+@.+\..+.+/,
    :message => "Invalid email format." }
  validates :email, uniqueness: { message: 'An account with that email already exists.'}
  has_secure_password
  validates :password, confirmation: { message: 'The two passwords do not match.'}
	validates :password_confirmation, presence: { message: 'Please confirm password.'}

	def self.login(params)
		user = User.find_by(email: params['email'])
		if user && user.authenticate(params['password'])
			return user.id
		else
			return nil
		end
	end

	
end
