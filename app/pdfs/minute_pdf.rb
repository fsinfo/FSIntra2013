# This is a 
#
#
class MinutePdf < Prawn::Document
  def initialize(minute, view)
    super()
    @minute = minute
    @view = view
    text "This is a minute #{@minute.id}"
  end
end