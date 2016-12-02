require 'rails_helper'
include RandomData

RSpec.describe Wiki, type: :model do
  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }
  let(:user) { User.create!(email: "user@blocipedia.com", password: "helloworld") }
  let(:wiki) { Wiki.create!(title: title, body: body, private: false, user: user) }

  it { is_expected.to belong_to(:user) }

  describe "attributes" do
    it "has title and body attributes" do
      expect(wiki).to have_attributes(title: wiki.title, body: wiki.body, private: wiki.private, user: wiki.user)
    end
  end
end
