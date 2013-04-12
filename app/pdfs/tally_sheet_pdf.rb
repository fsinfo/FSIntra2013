class TallySheetPdf < Prawn::Document
  def initialize(users, beverages, view)
    super(view)
    beverages = beverages.map(&:name)
    users = users.map(&:displayed_name)

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
      table.column_widths = table.width/table.column_length
    end
  end
end