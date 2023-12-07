require 'rails_helper'

RSpec.describe "Categories", type: :request do
  subject { json_response }

  let(:user) { create :user }
  let(:token) { create(:access_token, resource_owner_id: user.id).token }

  describe "GET /index" do
    let!(:category) { create(:category) }

    before do
      get '/categories', params: { access_token: token }
    end

    context "when valid token" do
      it "should respond successfully" do
        expect(response).to have_http_status(:success)
      end

      it { is_expected.to include({ "id" => category.id, "name" => category.name, "state" => category.state }) }
    end

    context "when invalid token" do
      let(:token) { 'invalid' }

      it "should be unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "GET /show" do
    let(:category) { create(:category) }

    before do
      get "/categories/#{category.id}", params: { access_token: token }
    end

    context "when valid token" do
      it "should respond successfully" do
        expect(response).to have_http_status(:success)
      end

      it { is_expected.to include("id" => category.id) }
      it { is_expected.to include("name" => category.name) }
      it { is_expected.to include("state" => category.state) }
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
      attributes_for(:category).merge({
        courses_attributes: [ attributes_for(:course), attributes_for(:course) ]
      })
    }

    context "when valid token" do
      it "should respond successfully" do
        post '/categories', params: { category: create_params, access_token: token }
        expect(response).to have_http_status(:success)
      end

      it "should create a category with two courses" do
        expect {
          post '/categories', params: { category: create_params, access_token: token }
        }.to change(Category, :count).by(1)
        .and change(Course, :count).by(2)
      end
    end

    context "when invalid token" do
      let(:token) { 'invalid' }

      before do
        post '/categories', params: { category: create_params, access_token: token }
      end

      it "should be unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "PUT /update" do
    let!(:category) { create(:category) }
    let!(:course) { create(:course, category: category) }

    let(:new_category_name) { Faker::Educator.subject }
    let(:new_course_name) { Faker::Educator.subject }
    let(:update_params) {
      {
        name: new_category_name,
        courses_attributes: [{ id: category.id, name: new_course_name}]
      }
    }

    context "when valid token" do
      it "should respond successfully" do
        put "/categories/#{category.id}", params: { category: update_params, access_token: token }
        expect(response).to have_http_status(:success)
      end

      it "should update category and category" do
        expect {
          put "/categories/#{category.id}", params: { category: update_params, access_token: token }
        }.to change{ category.reload.name }.to(new_category_name)
        .and change{ course.reload.name }.to(new_course_name)
      end
    end

    context "when invalid token" do
      let(:token) { 'invalid' }

      before do
        put "/categories/#{category.id}", params: { category: update_params, access_token: token }
      end

      it "should be unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:category) { create(:category) }

    context "when valid token" do
      it "should respond successfully" do
        delete "/categories/#{category.id}", params: { access_token: token }
        expect(response).to have_http_status(:success)
      end

      it "should destroy category" do
        expect {
          delete "/categories/#{category.id}", params: { access_token: token }
        }.to change(Category, :count).by(-1)
      end
    end

    context "when invalid token" do
      let(:token) { 'invalid' }

      before do
        delete "/categories/#{category.id}", params: { access_token: token }
      end

      it "should be unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
