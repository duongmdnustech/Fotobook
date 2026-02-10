require "rails_helper"

RSpec.describe Admin::HomesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/admin/homes").to route_to("admin/homes#index")
    end

    it "routes to #new" do
      expect(get: "/admin/homes/new").to route_to("admin/homes#new")
    end

    it "routes to #show" do
      expect(get: "/admin/homes/1").to route_to("admin/homes#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/admin/homes/1/edit").to route_to("admin/homes#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/admin/homes").to route_to("admin/homes#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/admin/homes/1").to route_to("admin/homes#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/admin/homes/1").to route_to("admin/homes#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/admin/homes/1").to route_to("admin/homes#destroy", id: "1")
    end
  end
end
