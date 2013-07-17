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
	STATUSES = [STATUS_PAID = 'paid', STATUS_MARKED_AS_PAID = 'marked_as_paid', STATUS_UNPAID = 'unpaid', STATUS_RUNNING = 'running']
	has_many :beverage_tabs, :dependent => :delete_all
	belongs_to :user

	scope :paid, -> { where(status: Tab::STATUS_PAID) }
	scope :unpaid, -> { where(status: [Tab::STATUS_MARKED_AS_PAID, Tab::STATUS_UNPAID]) }
	scope :running, -> { where(status: Tab::STATUS_RUNNING) }
	validates :status, inclusion: {in: STATUSES}, uniqueness: {scope: :user_id}

	accepts_nested_attributes_for :beverage_tabs

	def paid
		self.status = Tab::STATUS_PAID
	end

	def is_paid?
		self.status == Tab::STATUS_PAID
	end

	def marked_as_paid
		self.status = Tab::STATUS_MARKED_AS_PAID
	end

	def is_marked_as_paid?
		self.status == Tab::STATUS_MARKED_AS_PAID
	end

	def total_invoice
		self.beverage_tabs.inject(0.0) {|sum,beverage_tab| sum += beverage_tab.count * beverage_tab.price }
	end
end
