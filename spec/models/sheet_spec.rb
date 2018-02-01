
require 'rails_helper'

RSpec.describe Sheet, type: :model do
  context "validations" do
    describe "validates level value" do
      it { is_expected.to validate_numericality_of(:level).is_less_than(21).is_greater_than(0) }
    end
  end

  #context "filter method" do

  #end

  context "associations" do
    it { is_expected.to belong_to(:user) }
  end

end