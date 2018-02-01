class SheetsController < ApplicationController
	before_action	:find_sheet, only: [:show, :edit, :update]
	def find_sheet
		@sheet = Sheet.find(params[:id])
	end

	def new
		if !allowed?(level: 1)
			flash[:error] = "You must log in first."
			redirect_to sheets_path
		end
		@sheet = Sheet.new
	end

	def create
		if !allowed?(level: 1)
			flash[:error] = "You must log in first."
			redirect_to sheets_path
		end
		@sheet = current_user.sheets.new(sheet_params)
	  if @sheet.save
	    redirect_to @sheet
	  else
	    render 'new'
	  end
	end

	def show
	end

	def search
		@sheets = Sheet.filter(params.slice(:classes, :level, :race, :player, :min_level, :max_level))
		respond_to do |f|
			f.js
		end
	end

	def index
		@sheets = Sheet.filter(params.slice(:classes, :level, :race, :player, :min_level, :max_level))
	end

	def edit
		if !allowed?(level: 1.5, id: @sheet.user_id)
			flash[:error] = "You are not authorised to edit this sheet."
			redirect_to sheets_path
		end
	end

	def update
		if !allowed?(level: 1.5, id: @sheet.user_id)
			flash[:error] = "You are not authorised to edit this sheet."
			redirect_to sheets_path
		end

  	if @sheet.update_attributes(sheet_params)
  		@sheet.autocalc_all
  		@sheet.save
      redirect_to @sheet
    else
    	flash[:error] = "Error updating sheet"
      redirect_to '/'
    end
	end

	private
	def sheet_params
		params.require(:sheet).permit(:name, :classes, :level, :race, :gender, :background, :campaign, :hp, :ac, :initiative, :profbonus,
		 abilityscores: {} )
	end

end
