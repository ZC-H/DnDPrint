class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to '/'
		else
			p @user.errors
			flash[:danger] = @user.errors
			redirect_to '/sign_up'
		end
	end


	private
	def user_params
	  params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

end
