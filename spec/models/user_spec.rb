require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(email: "example@example.com", password: "helloworld")
    @user.skip_confirmation!
    @user.save
  end

  it { is_expected.to have_many(:wikis) }
  it { is_expected.to have_many(:collaborators)}

  describe "attributes" do
    it "should have name and email attributes" do
       expect(@user).to have_attributes(email: @user.email)
     end

     it "responds to role" do
       expect(@user).to respond_to(:role)
     end

     it "responds to admin?" do
       expect(@user).to respond_to(:admin?)
     end

     it "responds to standard?" do
       expect(@user).to respond_to(:standard?)
     end

     it "responds to premium?" do
       expect(@user).to respond_to(:premium?)
     end
  end

  describe "roles" do
    it "is standard by default" do
      expect(@user.role).to eql("standard")
    end

    context "standard user" do
      it "returns true for #standard?" do
        expect(@user.standard?).to be_truthy
      end

      it "returns false for #premium?" do
        expect(@user.premium?).to be_falsey
      end

      it "returns false for #admin?" do
        expect(@user.admin?).to be_falsey
      end
    end

    context "premium user" do
      before do
        @user.premium!
      end

      it "returns true for #standard?" do
        expect(@user.standard?).to be_falsey
      end

      it "returns false for #premium?" do
        expect(@user.premium?).to be_truthy
      end

      it "returns false for #admin?" do
        expect(@user.admin?).to be_falsey
      end
    end

    context "admin user" do
      before do
        @user.admin!
      end

      it "returns false for #standard?" do
        expect(@user.standard?).to be_falsey
      end

      it "returns false for #premium?" do
        expect(@user.premium?).to be_falsey
      end

      it "returns true for #admin?" do
        expect(@user.admin?).to be_truthy
      end
    end
  end

  describe "#collaborator_for(wiki)" do
    before do
      @wiki = Wiki.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, private: false, user: @user)
    end

    it "returns nil if the user is not a collaborator on the wiki" do
      expect(@user.collaborator_for(@wiki)).to be_nil
    end

    it "returns the collaborator if it exists" do
      collaborator = @user.collaborators.where(wiki: @wiki).create
      expect(@user.collaborator_for(@wiki)).to eq(collaborator)
    end
  end
end
