require 'spec_helper'

describe "minutes/items/edit" do
  before(:each) do
    @minutes_item = assign(:minutes_item, stub_model(Minutes::Item,
      :title => "MyString",
      :content => "MyText",
      :order => 1,
      :minute => nil
    ))
  end

  it "renders the edit minutes_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", minutes_item_path(@minutes_item), "post" do
      assert_select "input#minutes_item_title[name=?]", "minutes_item[title]"
      assert_select "textarea#minutes_item_content[name=?]", "minutes_item[content]"
      assert_select "input#minutes_item_order[name=?]", "minutes_item[order]"
      assert_select "input#minutes_item_minute[name=?]", "minutes_item[minute]"
    end
  end
end
