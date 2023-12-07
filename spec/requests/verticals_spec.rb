require 'rails_helper'

RSpec.describe "Verticals", type: :request do
  subject { json_response }

  let(:user) { create :user }
  let(:token) { create(:access_token, resource_owner_id: user.id).token }

  describe "GET /index" do
    let!(:vertical) { create(:vertical) }

    before do
      get '/verticals', params: { access_token: token }
    end

    context "when valid token" do
      it "should respond successfully" do
        expect(response).to have_http_status(:success)
      end

      it { is_expected.to include({ "id" => vertical.id, "name" => vertical.name }) }
    end

    context "when invalid token" do
      let(:token) { 'invalid' }

      it "should be unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "GET /show" do
    let(:vertical) { create(:vertical) }

    before do
      get "/verticals/#{vertical.id}", params: { access_token: token }
    end

    context "when valid token" do
      it "should respond successfully" do
        expect(response).to have_http_status(:success)
      end

      it { is_expected.to include("id" => vertical.id) }
      it { is_expected.to include("name" => vertical.name) }
    end

    context "when invalid token" do
      let(:token) { 'invalid' }

      it "should be unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "POST /create" do
    let(:create_params) {
      attributes_for(:vertical).merge({
        categories_attributes: [ attributes_for(:category), attributes_for(:category) ]
      })
    }

    context "when valid token" do
      it "should respond successfully" do
        post '/verticals', params: { vertical: create_params, access_token: token }
        expect(response).to have_http_status(:success)
      end

      it "should create a vertical with two categories" do
        expect {
          post '/verticals', params: { vertical: create_params, access_token: token }
        }.to change(Vertical, :count).by(1)
        .and change(Category, :count).by(2)
      end
    end

    context "when invalid token" do
      let(:token) { 'invalid' }

      before do
        post '/verticals', params: { vertical: create_params, access_token: token }
      end

      it "should be unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "PUT /update" do
    let!(:vertical) { create(:vertical) }
    let!(:category) { create(:category, vertical: vertical) }

    let(:new_vertical_name) { 'vertica' }
    let(:new_category_name) { 'catego' }
    let(:update_params) {
      {
        name: new_vertical_name,
        categories_attributes: [{ id: category.id, name: new_category_name}]
      }
    }

    context "when valid token" do
      it "should respond successfully" do
        put "/verticals/#{vertical.id}", params: { vertical: update_params, access_token: token }
        expect(response).to have_http_status(:success)
      end

      it "should update vertical and category" do
        expect {
          put "/verticals/#{vertical.id}", params: { vertical: update_params, access_token: token }
        }.to change{ vertical.reload.name }.to(new_vertical_name)
        .and change{ category.reload.name }.to(new_category_name)
      end
    end

    context "when invalid token" do
      let(:token) { 'invalid' }

      before do
        put "/verticals/#{vertical.id}", params: { vertical: update_params, access_token: token }
      end

      it "should be unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:vertical) { create(:vertical) }

    context "when valid token" do
      it "should respond successfully" do
        delete "/verticals/#{vertical.id}", params: { access_token: token }
        expect(response).to have_http_status(:success)
      end

      it "should destroy vertical" do
        expect {
          delete "/verticals/#{vertical.id}", params: { access_token: token }
        }.to change(Vertical, :count).by(-1)
      end
    end

    context "when invalid token" do
      let(:token) { 'invalid' }

      before do
        delete "/verticals/#{vertical.id}", params: { access_token: token }
      end

      it "should be unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
