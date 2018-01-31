class SheetsController < ApplicationController
	before_action	:find_sheet, only: [:show, :edit, :update]
	def find_sheet
		@sheet = Sheet.find(params[:id])
	end

	def new
		@sheet = Sheet.new
	end

	def create
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
		p "Yeah"
		@sheets = Sheet.filter(params.slice(:classes, :level, :race, :player, :min_level, :max_level))
		respond_to do |f|
			f.js
		end
	end

	def index
		p "AAAAAAAAa"
		p params
		@sheets = Sheet.filter(params.slice(:classes, :level, :race, :player, :min_level, :max_level))
	end

	def edit
	end

	def update
  	if @sheet.update_attributes(sheet_params)
      redirect_to @sheet
    else
    	flash[:danger] = "Error updating sheet"
      render 'edit'
    end
	end

	private
	def sheet_params
		params.require(:sheet).permit(:name, :classes, :level, :race)
	end

end
