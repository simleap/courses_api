require 'rails_helper'

RSpec.describe "Courses", type: :request do
  subject { json_response }

  let(:user) { create :user }
  let(:token) { create(:access_token, resource_owner_id: user.id).token }

  describe "GET /index" do
    let!(:course) { create(:course) }

    before do
      get '/courses', params: { access_token: token }
    end

    context "when valid token" do
      it "should respond successfully" do
        expect(response).to have_http_status(:success)
      end

      it { is_expected.to include({ "id" => course.id, "name" => course.name, "state" => course.state }) }
    end

    context "when invalid token" do
      let(:token) { 'invalid' }

      it "should be unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "GET /show" do
    let(:course) { create(:course) }

    before do
      get "/courses/#{course.id}", params: { access_token: token }
    end

    context "when valid token" do
      it "should respond successfully" do
        expect(response).to have_http_status(:success)
      end

      it { is_expected.to include("id" => course.id) }
      it { is_expected.to include("name" => course.name) }
      it { is_expected.to include("state" => course.state) }
    end

    context "when invalid token" do
      let(:token) { 'invalid' }

      it "should be unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "POST /create" do
    let(:create_params) { attributes_for(:course) }

    context "when valid token" do
      it "should respond successfully" do
        post '/courses', params: { course: create_params, access_token: token }
        expect(response).to have_http_status(:success)
      end

      it "should create a course" do
        expect {
          post '/courses', params: { course: create_params, access_token: token }
        }.to change(Course, :count).by(1)
      end
    end

    context "when invalid token" do
      let(:token) { 'invalid' }

      before do
        post '/courses', params: { course: create_params, access_token: token }
      end

      it "should be unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "PUT /update" do
    let!(:course) { create(:course) }

    let(:new_course_name) { Faker::Educator.subject }
    let(:update_params) {{ name: new_course_name }}

    context "when valid token" do
      it "should respond successfully" do
        put "/courses/#{course.id}", params: { course: update_params, access_token: token }
        expect(response).to have_http_status(:success)
      end

      it "should update course and course" do
        expect {
          put "/courses/#{course.id}", params: { course: update_params, access_token: token }
        }.to change{ course.reload.name }.to(new_course_name)
      end
    end

    context "when invalid token" do
      let(:token) { 'invalid' }

      before do
        put "/courses/#{course.id}", params: { course: update_params, access_token: token }
      end

      it "should be unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:course) { create(:course) }

    context "when valid token" do
      it "should respond successfully" do
        delete "/courses/#{course.id}", params: { access_token: token }
        expect(response).to have_http_status(:success)
      end

      it "should destroy course" do
        expect {
          delete "/courses/#{course.id}", params: { access_token: token }
        }.to change(Course, :count).by(-1)
      end
    end

    context "when invalid token" do
      let(:token) { 'invalid' }

      before do
        delete "/courses/#{course.id}", params: { access_token: token }
      end

      it "should be unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
