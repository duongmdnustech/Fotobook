require 'rails_helper'

RSpec.describe "admin/homes/edit", type: :view do
  let(:admin_home) {
    Admin::Home.create!()
  }

  before(:each) do
    assign(:admin_home, admin_home)
  end

  it "renders the edit admin_home form" do
    render

    assert_select "form[action=?][method=?]", admin_home_path(admin_home), "post" do
    end
  end
end
