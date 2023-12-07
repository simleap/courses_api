require 'rails_helper'

RSpec.describe "Verticals", type: :request do
  subject { json_response }

  let(:user) { create :user }
  let(:token) { create :access_token, resource_owner_id: user.id }

  describe "GET /index" do
    context "when valid token" do
      let!(:vertical) { create(:vertical) }

      before do
        get '/verticals', params: { access_token: token.token }
      end

      it "should respond successfully" do
        expect(response).to have_http_status(:success)
      end

      it { is_expected.to include({ "id" => vertical.id, "name" => vertical.name }) }
    end

    context "when invalid token" do
      before do
        get '/verticals', params: { access_token: 'invalid' }
      end

      it "should be unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
