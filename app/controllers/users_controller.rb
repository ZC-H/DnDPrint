class UsersController < ApplicationController
	before_action	:find_user, only: [:show, :edit, :update]
	def find_user
		@user = User.find(params[:id])
	end

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

	def show
	end

	def edit
	end

	def update
	end

	def mysheets
		@sheets = Sheet.where(user_id: current_user.id)
	end
	
	def sign_in
		#Intentionally blank: See sign_in_check
	end

	def sign_out
		session.clear
		redirect_to sign_in_path
	end

	def sign_in_check
		id = User.login(params)
		if id
			session[:user_id] = id
			redirect_to '/'
		else
			flash[:error] = "Invalid user details."
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
