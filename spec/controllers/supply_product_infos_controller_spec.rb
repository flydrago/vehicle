require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe SupplyProductInfosController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # SupplyProductInfo. As you add validations to SupplyProductInfo, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SupplyProductInfosController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all supply_product_infos as @supply_product_infos" do
      supply_product_info = SupplyProductInfo.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:supply_product_infos)).to eq([supply_product_info])
    end
  end

  describe "GET #show" do
    it "assigns the requested supply_product_info as @supply_product_info" do
      supply_product_info = SupplyProductInfo.create! valid_attributes
      get :show, params: {id: supply_product_info.to_param}, session: valid_session
      expect(assigns(:supply_product_info)).to eq(supply_product_info)
    end
  end

  describe "GET #new" do
    it "assigns a new supply_product_info as @supply_product_info" do
      get :new, params: {}, session: valid_session
      expect(assigns(:supply_product_info)).to be_a_new(SupplyProductInfo)
    end
  end

  describe "GET #edit" do
    it "assigns the requested supply_product_info as @supply_product_info" do
      supply_product_info = SupplyProductInfo.create! valid_attributes
      get :edit, params: {id: supply_product_info.to_param}, session: valid_session
      expect(assigns(:supply_product_info)).to eq(supply_product_info)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new SupplyProductInfo" do
        expect {
          post :create, params: {supply_product_info: valid_attributes}, session: valid_session
        }.to change(SupplyProductInfo, :count).by(1)
      end

      it "assigns a newly created supply_product_info as @supply_product_info" do
        post :create, params: {supply_product_info: valid_attributes}, session: valid_session
        expect(assigns(:supply_product_info)).to be_a(SupplyProductInfo)
        expect(assigns(:supply_product_info)).to be_persisted
      end

      it "redirects to the created supply_product_info" do
        post :create, params: {supply_product_info: valid_attributes}, session: valid_session
        expect(response).to redirect_to(SupplyProductInfo.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved supply_product_info as @supply_product_info" do
        post :create, params: {supply_product_info: invalid_attributes}, session: valid_session
        expect(assigns(:supply_product_info)).to be_a_new(SupplyProductInfo)
      end

      it "re-renders the 'new' template" do
        post :create, params: {supply_product_info: invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested supply_product_info" do
        supply_product_info = SupplyProductInfo.create! valid_attributes
        put :update, params: {id: supply_product_info.to_param, supply_product_info: new_attributes}, session: valid_session
        supply_product_info.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested supply_product_info as @supply_product_info" do
        supply_product_info = SupplyProductInfo.create! valid_attributes
        put :update, params: {id: supply_product_info.to_param, supply_product_info: valid_attributes}, session: valid_session
        expect(assigns(:supply_product_info)).to eq(supply_product_info)
      end

      it "redirects to the supply_product_info" do
        supply_product_info = SupplyProductInfo.create! valid_attributes
        put :update, params: {id: supply_product_info.to_param, supply_product_info: valid_attributes}, session: valid_session
        expect(response).to redirect_to(supply_product_info)
      end
    end

    context "with invalid params" do
      it "assigns the supply_product_info as @supply_product_info" do
        supply_product_info = SupplyProductInfo.create! valid_attributes
        put :update, params: {id: supply_product_info.to_param, supply_product_info: invalid_attributes}, session: valid_session
        expect(assigns(:supply_product_info)).to eq(supply_product_info)
      end

      it "re-renders the 'edit' template" do
        supply_product_info = SupplyProductInfo.create! valid_attributes
        put :update, params: {id: supply_product_info.to_param, supply_product_info: invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested supply_product_info" do
      supply_product_info = SupplyProductInfo.create! valid_attributes
      expect {
        delete :destroy, params: {id: supply_product_info.to_param}, session: valid_session
      }.to change(SupplyProductInfo, :count).by(-1)
    end

    it "redirects to the supply_product_infos list" do
      supply_product_info = SupplyProductInfo.create! valid_attributes
      delete :destroy, params: {id: supply_product_info.to_param}, session: valid_session
      expect(response).to redirect_to(supply_product_infos_url)
    end
  end

end