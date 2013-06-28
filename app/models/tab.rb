# == Schema Information
#
# Table name: tabs
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  status     :string(255)      default("running")
#

class Tab < ActiveRecord::Base
	STATUSES = ['paid', 'marked_as_paid', 'unpaid', 'running']
	has_many :beverage_tabs, :dependent => :delete_all
	belongs_to :user

	scope :paid, -> { where(status: 'paid').order('created_at DESC') }
	scope :unpaid, -> { where(status: ['marked_as_paid','unpaid']).order('created_at DESC') }
	scope :running, -> { where(status: 'running') }

	# accepts_nested_attributes_for :beverage_tabs, :reject_if => lambda { |bt| bt.count == 0 }
	accepts_nested_attributes_for :beverage_tabs

	default_scope -> { includes(:beverage_tabs) }

	def paid
		self.status = 'paid'
	end

	def is_paid?
		self.status == 'paid'
	end

	def marked_as_paid
		self.status = 'marked_as_paid'
	end

	def is_marked_as_paid?
		self.status == 'marked_as_paid'
	end

	def total_invoice
		self.beverage_tabs.inject(0.0) {|sum,beverage_tab| sum += beverage_tab.count * beverage_tab.price }
	end
end
