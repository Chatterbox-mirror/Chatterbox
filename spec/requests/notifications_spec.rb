require 'rails_helper'

RSpec.describe "Notifications", :type => :request do
  describe "GET /notifications" do
    it "works! (now write some real specs)" do
      get notifications_path
      expect(response.status).to be(200)
    end
  end
end
