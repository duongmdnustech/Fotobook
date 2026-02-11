require 'rails_helper'

RSpec.describe "admin/homes/index", type: :view do
  before(:each) do
    assign(:admin_homes, [
      Admin::Home.create!(),
      Admin::Home.create!()
    ])
  end

  it "renders a list of admin/homes" do
    render
    cell_selector = 'div>p'
  end
end
