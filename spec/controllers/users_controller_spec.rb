require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  let(:user) { create(:user) }
  describe "#show" do
    it "responds successfully" do
      get :show, :params => { :id => user.id }
      expect(response).to be_successful
    end
    it "returns a 200 response" do
      get :show, :params => { :id => user.id }
      expect(response).to have_http_status "200"
    end
  end
end