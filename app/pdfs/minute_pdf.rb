# This is the PDF creating "template" (<-suspicious quotation marks)
# See http://blog.idyllic-software.com/blog/bid/204082/Creating-PDF-using-Prawn-in-Ruby-on-Rails for a nice introduction
# and http://prawn.majesticseacreature.com/ for prawn itself
class MinutePdf < Prawn::Document
  def initialize(minute, view)
    super()
    @minute = minute
    @view = view
    
    # these are the elements of the generated pdf
    agenda
    @minute.items.each do |i|
    	item i
    end

  end

  # create the agenda
  def agenda
 	@minute.items.each do |i|
  		text "#{t Minutes::Item.model_name.human} #{i.title}" # TODO Nummer des TOP
  	end
  end

  def item item
  end
end