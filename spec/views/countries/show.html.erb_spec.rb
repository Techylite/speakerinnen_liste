require 'rails_helper'

RSpec.describe "countries/show", :type => :view do
  before(:each) do
    @country = assign(:country, Country.create!(
      :name => "Name",
      :language => "Language"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Language/)
  end
end
