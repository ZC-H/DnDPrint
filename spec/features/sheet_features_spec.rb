require 'rails_helper'


	describe "Sheets" do
		let(:user1) { User.create(name: "Pyramid", email: "pyramidi@sphinx.net", password: "aaaa", password_confirmation: "aaaa") }

		describe "POST /sheet" do
			it "properly creates a sheet" do
				page.driver.browser.set_cookie("auth_token=#{user1.auth_token}")
				visit new_sheet_path
				fill_in "sheet_name", :with => "Gandalf"
				fill_in "sheet_race", :with => "Human"
				fill_in "sheet_classes", :with => "Wizard"
				click_button "Submit Sheet"
				expect(page).to have_content("Gandalf")
				expect(page).to have_content("Human Wizard")
			end
		end

	end
