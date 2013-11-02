require 'spec_helper'

describe "minutes/items/index" do
  before(:each) do
    assign(:minutes_items, [
      stub_model(Minutes::Item,
        :title => "Title",
        :content => "MyText",
        :order => 1,
        :minute => nil
      ),
      stub_model(Minutes::Item,
        :title => "Title",
        :content => "MyText",
        :order => 1,
        :minute => nil
      )
    ])
  end

  it "renders a list of minutes/items" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
