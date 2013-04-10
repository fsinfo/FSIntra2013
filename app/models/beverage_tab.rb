# == Schema Information
#
# Table name: beverage_tabs
#
#  id          :integer          not null, primary key
#  beverage_id :integer
#  tab_id      :integer
#  count       :integer
#  price       :decimal(8, 2)
#  created_at  :datetime
#  updated_at  :datetime
#

class BeverageTab < ActiveRecord::Base
	belongs_to :beverage
	belongs_to :tab

	after_initialize :init

	def init
		self.count ||= 0
	end
end
