require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "#index" do
    before do
      @user = FactoryBot.create(:user)
    end

    it "responds successfully" do
      sign_in @user
      get :index
      expect(response).to be_successful
    end

    it "returns a 200 response" do
      sign_in @user
      get :index
      expect(response).to have_http_status "200"
    end
  end

  describe "GET #new" do
    before {get :new}

    it "should render new user" do
      expect(response).to render_template :new
    end

    it "should found" do
      expect(response).to have_http_status 200
    end
  end

  describe "POST #create" do
    it "should create new user" do
      expect {post :create, params: {user: FactoryBot.attributes_for(:user)}}
        .to change(User, :count).by(1)
    end

    it "should found" do
      expect(response).to have_http_status 200
    end
  end
end
