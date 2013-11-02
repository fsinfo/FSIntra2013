require 'spec_helper'

describe "minutes/motions/index" do
  before(:each) do
    assign(:minutes_motions, [
      stub_model(Minutes::Motion,
        :order => 1,
        :mover => nil,
        :pro => 2,
        :con => 3,
        :abs => 4,
        :rationale => "MyText",
        :amount => 5,
        :minutes_item => nil,
        :approved => false
      ),
      stub_model(Minutes::Motion,
        :order => 1,
        :mover => nil,
        :pro => 2,
        :con => 3,
        :abs => 4,
        :rationale => "MyText",
        :amount => 5,
        :minutes_item => nil,
        :approved => false
      )
    ])
  end

  it "renders a list of minutes/motions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
