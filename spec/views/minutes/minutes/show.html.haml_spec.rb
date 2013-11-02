require 'spec_helper'

describe "minutes/minutes/show" do
  before(:each) do
    @minutes_minute = assign(:minutes_minute, stub_model(Minutes::Minute,
      :keeper_of_the_minutes => nil,
      :chairperson => nil,
      :has_quorum => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/false/)
  end
end
