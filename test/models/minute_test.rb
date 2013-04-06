require 'test_helper'

class MinuteTest < ActiveSupport::TestCase
  test "minutes must have date" do
  	minute = Minute.new
  	assert !minute.save
  end

  test "minute starts with state" do
  	minute = Minute.new
  	minute.save
  	assert minute.status == "draft"
	end

	test "minute can be accepted" do
		minute = Minute.new
		minute.save
		minute.accept
		assert minute.status == "accepted"
	end

	test "newly accepted minute returns true" do
		minute = Minute.new
		minute.save
		assert minute.accept
	end

	test "already accepted minute returns false" do
		minute = Minute.new
		minute.save
		minute.accept
		assert !minute.accept
	end
end
