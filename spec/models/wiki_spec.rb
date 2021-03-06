require 'rails_helper'
include RandomData

RSpec.describe Wiki, type: :model do
  before do
    @user = User.new(email: "example@example.com", password: "helloworld")
    @user.skip_confirmation!
    @user.save
  end
  
  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }
  let(:wiki) { Wiki.create!(title: title, body: body, private: false, user: @user) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:collaborators)}

  describe "attributes" do
    it "has title and body attributes" do
      expect(wiki).to have_attributes(title: wiki.title, body: wiki.body, private: wiki.private, user: wiki.user)
    end
  end
end
