require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

  describe "GET #index" do
    it "returns http success and renders template" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template("index")
    end
  end

  describe "GET #about" do
    it "returns http success and renders template" do
      get :about
      expect(response).to have_http_status(:success)
      expect(response).to render_template("about")
    end
  end

end
