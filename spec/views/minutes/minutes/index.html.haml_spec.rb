require 'spec_helper'

describe "minutes/minutes/index" do
  before(:each) do
    assign(:minutes_minutes, [
      stub_model(Minutes::Minute,
        :keeper_of_the_minutes => nil,
        :chairperson => nil,
        :has_quorum => false
      ),
      stub_model(Minutes::Minute,
        :keeper_of_the_minutes => nil,
        :chairperson => nil,
        :has_quorum => false
      )
    ])
  end

  it "renders a list of minutes/minutes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
