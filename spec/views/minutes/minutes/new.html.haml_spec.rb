require 'spec_helper'

describe "minutes/minutes/new" do
  before(:each) do
    assign(:minutes_minute, stub_model(Minutes::Minute,
      :keeper_of_the_minutes => nil,
      :chairperson => nil,
      :has_quorum => false
    ).as_new_record)
  end

  it "renders new minutes_minute form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", minutes_minutes_path, "post" do
      assert_select "input#minutes_minute_keeper_of_the_minutes[name=?]", "minutes_minute[keeper_of_the_minutes]"
      assert_select "input#minutes_minute_chairperson[name=?]", "minutes_minute[chairperson]"
      assert_select "input#minutes_minute_has_quorum[name=?]", "minutes_minute[has_quorum]"
    end
  end
end
