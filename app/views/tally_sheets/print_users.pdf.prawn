require 'barby/barcode/code_128' 
require 'barby/outputter/prawn_outputter'

user_prefix = 'user__'
code_width = 120
code_height = 30
rows = 14 
columns = 2
count = 0

pdf.define_grid(:columns => columns, :rows => rows, :gutter => 5)
@users.each do |user|
  column = count % columns
  if count/columns == rows
    pdf.start_new_page 
    count = 0
  end
  pdf.grid(count/columns,column).bounding_box do 
    barcode = Barby::Code128B.new "#{user_prefix}#{user.loginname}"
    pdf.stroke_horizontal_rule
    pdf.pad(3) { pdf.text user.displayed_name }
    barcode.annotate_pdf(pdf, :height => code_height)
  end
  count += 1
end
