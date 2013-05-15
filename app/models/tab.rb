# == Schema Information
#
# Table name: tabs
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#  paid           :boolean
#  marked_as_paid :boolean
#

class Tab < ActiveRecord::Base
	has_many :beverage_tabs, :dependent => :delete_all
	has_many :beverages, :through => :beverage_tabs
	belongs_to :user

	validates :total_invoice, :numericality => {:greater_than => 0}

	scope :paid, -> { where(paid: true).order('created_at DESC') }
	scope :unpaid, -> { where(paid: false).order('created_at DESC') }
	
	accepts_nested_attributes_for :beverage_tabs

	def is_paid
		self.paid = true
	end

	def is_paid?
		self.paid
	end

	def total_invoice
		total = 0.0
		self.beverage_tabs.each do |b|
			total += b.price * b.count
		end
		return total
	end
end
