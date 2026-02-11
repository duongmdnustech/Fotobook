require 'rails_helper'

RSpec.describe "admin/homes/new", type: :view do
  before(:each) do
    assign(:admin_home, Admin::Home.new())
  end

  it "renders new admin_home form" do
    render

    assert_select "form[action=?][method=?]", admin_homes_path, "post" do
    end
  end
end
