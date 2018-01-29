class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = user.id
			redirect_to '/'
		else
			p @user.errors
			flash[:danger] = @user.errors
			redirect_to '/sign_up'
		end
	end

	def sign_in
	end

	def sign_in_check
		p "AAAAAAAAAAAAAAAAAAA"
		p params
		id = User.login(params)
		if id
			session[:user_id] = id
			redirect_to '/'
		else
			redirect '/sign_in'
		end
	end


	private
	def user_params
	  params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

end
