class TallySheetPdf < Prawn::Document
  include ActionView::Helpers::NumberHelper

  def initialize(users, beverages)
    super({:page_layout => :landscape, :page_size => "A4"}) 
    beverages = beverages.map{|b| "#{b.name} (#{number_to_human(b.capacity, :separator => ',', :significant => false, :precision => 2, :units => {:unit => 'l'})})"}
    users = users.map(&:short_name)

    # set up table
    data = Array.new(users.count+1) { Array.new(beverages.count+1) }

    # first row
    for i in (1..beverages.count) do
      data[0][i] = beverages[i-1]
    end

    # first column
    for i in (1..users.count) do
      data[i][0] = users[i-1]
    end

    table(data, :header => true, :width => bounds.width) do |table|
      table.row_colors = ['ffffff','C9C9C9']
      # table.column_widths = table.width/table.column_length
      name_width = 110
      table.columns(1..table.column_length).width = (table.width-name_width)/(table.column_length-1)
      table.column(0).width = name_width
    end
  end
end