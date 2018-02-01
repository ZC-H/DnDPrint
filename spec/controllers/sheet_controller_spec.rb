require 'spec_helper'


	describe "Sheets" do
		let(:user1) { User.create(name: "Pyramid", email: "pyramidi@sphinx.net", password: "aaaa", password_confirmation: "aaaa") }

		describe "POST /sheet" do
			it "properly creates a sheet" do
				page.set_rack_session(user_id: user1.id)
				visit new_sheet_path
				fill_in "Character name", :with => "Gandalf"
				save_and_open_page
				click_button "Submit Sheet"
				page.should have_content("Gandalf")
			end
		end

	end
