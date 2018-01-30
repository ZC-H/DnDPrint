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
		#Intentionally blank: See sign_in_check
	end

	def sign_out
		session.clear
		redirect_to '/'
	end

	def sign_in_check
		id = User.login(params)
		if id
			session[:user_id] = id
			redirect_to '/'
		else
			redirect_to '/sign_in'
		end
	end

	def google
		user_id = User.googleaccount(request.env["omniauth.auth"])
		session[:user_id] = user_id
		redirect_to '/'
	end


	private
	def user_params
	  params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

end
