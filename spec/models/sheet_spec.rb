
require 'rails_helper'

RSpec.describe Sheet, type: :model do

  let(:user1) { User.create(name: "Pyramid", email: "pyramidi@sphinx.net", password: "aaaa", password_confirmation: "aaaa") }
  let(:sheet1) { Sheet.create(name: "Igloo", race: "Human", level: 5, classes: "Wizard", user: user1, 
    abilityscores: {"str" => 12,"dex" => 14, "con" => 5, "int" => 16, "wis" => 10, "cha" => 13})}
  let(:sheet2) { Sheet.create(name: "Tomato", race: "Elf", level: 7, classes: "Fighter", user: user1)}
  let(:sheet3) { Sheet.create(name: "Salsa", race: "Human", level: 11, classes: "Rogue", user: user1)}

  context "validations" do
    describe "validates level value" do
      it { is_expected.to validate_numericality_of(:level).is_less_than(21).is_greater_than(0) }
    end
  end

  context "filter method" do
    it "allows filtering by class" do
      expect(Sheet.filter({'classes' => "Fighter"}) ).to include(sheet2)
    end

    it "allows filtering by race" do
      expect(Sheet.filter({'race' => "Human"}) ).to include(sheet1,sheet3)
    end

    it "allows filtering by level range" do
      expect(Sheet.filter({'min_level' => 6, 'max_level' => 12}) ).to include(sheet2,sheet3)
    end

    it "does not raise an error if no results are found" do
      expect{Sheet.filter({'race' => "Elephant"}) }.not_to raise_error
    end
  end

  context "calculation methods" do
    #calc_ability_mods
    describe "#calc_ability_mods" do
      it "ability mods get calculated correctly" do
        sheet1.calc_ability_mods
        expect(sheet1.abilityscores['int-mod']).to eq 3
        expect(sheet1.abilityscores['con-mod']).to eq -3
      end

      it "still works with some scores missing" do
        sheet2.abilityscores = {"str" => 20,"dex" => 14, "con" => 16}
        sheet2.calc_ability_mods
        expect(sheet2.abilityscores['str-mod']).to eq 5
        expect(sheet2.abilityscores['int-mod']).to eq nil
      end

      it "is tolerant of invalid input" do
        sheet3.abilityscores = {"str" => 'hello'}
        sheet3.calc_ability_mods
        expect(sheet3.abilityscores['str-mod']).to eq nil
      end
    end

    #calc_profbonus
    describe "#calc_profbonus" do
      it "calculates proficiency bonus properly" do
        sheet1.calc_profbonus
        expect(sheet1.profbonus).to eq 3
      end
      it "is tolerant of invalid inputs" do
        sheet2.level = nil
        sheet2.calc_profbonus
        expect(sheet2.profbonus).to eq nil
      end

    end

  end

  context "associations" do
    it { is_expected.to belong_to(:user) }
  end

end