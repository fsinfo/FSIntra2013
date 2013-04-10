class Tab < ActiveRecord::Base
	has_many :beverage_tabs
	has_many :beverages, :through => :beverage_tabs
	belongs_to :user
end
