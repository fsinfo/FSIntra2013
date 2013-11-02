require 'spec_helper'

describe "minutes/items/new" do
  before(:each) do
    assign(:minutes_item, stub_model(Minutes::Item,
      :title => "MyString",
      :content => "MyText",
      :order => 1,
      :minute => nil
    ).as_new_record)
  end

  it "renders new minutes_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", minutes_items_path, "post" do
      assert_select "input#minutes_item_title[name=?]", "minutes_item[title]"
      assert_select "textarea#minutes_item_content[name=?]", "minutes_item[content]"
      assert_select "input#minutes_item_order[name=?]", "minutes_item[order]"
      assert_select "input#minutes_item_minute[name=?]", "minutes_item[minute]"
    end
  end
end
