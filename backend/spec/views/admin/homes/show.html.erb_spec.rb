require 'rails_helper'

RSpec.describe "admin/homes/show", type: :view do
  before(:each) do
    assign(:admin_home, Admin::Home.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
