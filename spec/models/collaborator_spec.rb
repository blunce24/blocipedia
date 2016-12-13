require 'rails_helper'

RSpec.describe Collaborator, type: :model do
  before do
    @user = User.new(email: "example@example.com", password: "helloworld")
    @user.skip_confirmation!
    @user.save
  end

  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }
  let(:wiki) { Wiki.create!(title: title, body: body, private: false, user: @user) }
  let(:collaborator) { Collaborator.create!(user: @user, wiki: wiki) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:wiki) }
end
