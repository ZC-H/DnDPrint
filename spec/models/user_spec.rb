
require 'rails_helper'

RSpec.describe User, type: :model do

  context "validations" do

    it "should have name, email and password_digest" do
      should have_db_column(:name).of_type(:string)
      should have_db_column(:email).of_type(:string)
      should have_db_column(:password_digest).of_type(:string)
    end

    describe "validates presence and uniqueness of email" do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_uniqueness_of(:email) }
    end

    describe "validates password" do
      it { is_expected.to validate_presence_of(:password) }
      it { is_expected.to validate_presence_of(:password_confirmation) }
      it { is_expected.to validate_confirmation_of(:password) }
    end

    # happy_path
    describe "can be created when all attributes are present" do
      When(:user) { User.new(
        name: "Salad Mayo",
        email: "salad@mayo.net",
        password: "aaaa",
        password_confirmation: "aaaa"
      )}
      Then { user.valid? == true }
    end

    # unhappy_path

    describe "cannot be created without an email" do
      When(:user) { User.new(name: "Green Onion", password: "aaaa", password_confirmation: "aaaa") }
      Then { user.valid? == false }
    end


    describe "cannot be created without a password" do
      When(:user) { User.new(name: "Green Onion", email: "green@onion.slice") }
      Then { user.valid? == false }
    end



    describe "should check that emails fit the right format" do
      let(:user1) { User.create(name: "Igloo", email: "igloo@north.pole", password: "aaaa", password_confirmation: "aaaa")}
      let(:user2) { User.create(name: "Pyramid",email: "pyramidi.sphinx", password: "aaaa", password_confirmation: "aaaa") }

      # happy_path
      it "Valid emails work" do
        expect(user1).to be_valid
      end

      # unhappy_path
      it "Invalid emails are rejected" do
        expect(user2).to be_invalid
      end
    end
  end

  context 'associations with dependency' do
    it { is_expected.to have_many(:sheets).dependent(:destroy)}
  end


  context "login authentication" do
    let(:user1) { User.create(name: "Igloo", email: "igloo@north.pole", password: "aaaa", password_confirmation: "aaaa") }

    it "method requires proper parameters" do
      expect {User.login}.to raise_error(ArgumentError)
    end

    it "allows proper user login and returns user ID" do
      expect(User.login({'email' => user1.email, 'password' => "aaaa"}) ).to eq user1.id
    end

    it "rejects users with incorrect passwords" do
      expect(User.login({'email' => user1.email, 'password' => 'bbbb'}) ).to be nil
    end
  end

end
