require "rails_helper"

RSpec.describe SessionsController, type: :controller do
  describe "GET #new" do
    before {get :new}

    it "should render login page" do
      expect(response).to render_template :new
    end

    it "should found" do
      expect(response).to have_http_status 200
    end
  end

  describe "POST #create" do
    let!(:user) {FactoryBot.create :user, email: "a@gmail.com", password: "12345678"}

    context "successful" do
      before do
        post :create, params: {session: {email: "a@gmail.com", password: "12345678"}}
      end

      let(:user1) {User.find_by(email: controller.params[:session][:email].downcase)}

      it "should find user by email" do
        expect(user1).to eq(user)
      end

      it "should authenticate user" do
        expect(user1.authenticate(controller.params[:session][:password])).to eq user
      end

      it "should found" do
        expect(response).to have_http_status 302
      end
    end

    context "failed" do
      before do
        post :create, params: {session: {email: "a@gmail.com", password: "87654321"}}
      end

      let(:user2) {User.find_by(email: controller.params[:session][:email].downcase)}

      it "should find user by email" do
        expect(user2).to eq(user)
      end

      it "should not authenticate user" do
        expect(user2.authenticate(controller.params[:session][:password])).not_to eq user
      end

      it "should render login page" do
        expect(response).to render_template :new
      end

      it {expect(flash.now[:danger]).to match(I18n.t("invalid"))}
    end
  end

  describe "DELETE #destroy" do
    before do
      delete :destroy
      sign_out
    end

    it "should delete user in session" do
      expect(session[:user_id]).to be_nil
      expect(@current_user).to be_nil
    end

    it "should redirect to login page" do
      expect(response).to redirect_to root_url
    end

    it "should found" do
      expect(response).to have_http_status 302
    end
  end
end
