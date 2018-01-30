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

	def index
		@sheets = Sheet.all
	end

	def edit
	end

	private
	def sheet_params
		params.require(:sheet).permit(:name, :class, :level, :race)
	end

end
