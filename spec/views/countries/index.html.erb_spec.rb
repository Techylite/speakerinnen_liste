require 'rails_helper'

RSpec.describe "countries/index", :type => :view do
  before(:each) do
    assign(:countries, [
      Country.create!(
        :name => "Name",
        :language => "Language"
      ),
      Country.create!(
        :name => "Name",
        :language => "Language"
      )
    ])
  end

  it "renders a list of countries" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Language".to_s, :count => 2
  end
end
