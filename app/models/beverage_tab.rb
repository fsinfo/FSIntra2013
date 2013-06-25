# == Schema Information
#
# Table name: beverage_tabs
#
#  id         :integer          not null, primary key
#  tab_id     :integer
#  count      :integer
#  price      :decimal(8, 2)
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)
#  capacity   :decimal(8, 2)
#

class BeverageTab < ActiveRecord::Base
	belongs_to :tab

  validates :count, numericality: {greater_than: 0}

	after_initialize :init

	def init
		self.count ||= 0
	end
end
