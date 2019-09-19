require 'rails_helper'

RSpec.describe SubjectController, type: :controller do
  let!(:subject) { FactoryBot.create :subject }

  describe "GET #index" do
    it "responds successfully"	do
      get :index
      expect(response).to be_successful
    end

    it "returns a 200 response"	do								
      get :index
      expect(response).to have_http_status "200"
    end
  end
  
  
  describe "GET #new" do
    before {get :new}

    it "should be success" do
      expect(response).to have_http_status :ok
    end

    it "should render new page" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "create successful" do
      before do
        post :create, params: {subject: FactoryBot.attributes_for(:subject)}
      end

      it "should create new subject" do
        expect{post :create, params:{subject: FactoryBot.attributes_for(:subject)}}
          .to change(Subject, :count).by(1)
      end

      it "should redirects_to(@subject)" do
        subject.should redirect_to(assigns(:subject))
      end

      it "should flash success" do
        expect(flash[:info]).to match(I18n.t("create_subject_successful"))
      end
    end

    context "create failed" do
      before do
        post :create, params: {subject: {name: nil}}
      end

      it "should create false with no name" do
        expect{post :create, params: {subject: {name: nil}}}.to change(Subject, :count).by(0)
      end

      it "should flash failed" do
        expect(flash[:danger]).to match(I18n.t("create_subject_failed"))
      end

      it "should render new page" do
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #show" do
      before do
        get :show, params: {id: subject.id}
      end

      it "should render show page" do
        expect(response).to render_template(:show)
      end

      it "should be success" do
        expect(response).to have_http_status(:ok)
      end
  end

  describe "subject params" do
    it do
      params = {subject: {name: "JS"}}
      is_expected.to permit(:name).for(:create, params: params).on(:subject)
    end 
  end
end
