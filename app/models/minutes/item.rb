class Minutes::Item < ActiveRecord::Base
	belongs_to :minute

	validates_presence_of :title, :content, :on => :update
end
