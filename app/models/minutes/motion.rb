class Minutes::Motion < ActiveRecord::Base
  belongs_to :mover, :class_name => "User"
  belongs_to :item

  validates_presence_of :rationale, :mover, :pro, :abs, :con
end
