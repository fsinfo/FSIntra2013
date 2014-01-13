class BeverageStats
  def self.get_hourly_stats(n_hours)
    # start_time = DateTime.now.beginning_of_hour - n_hours.hours
    start_time = (DateTime.now.utc.beginning_of_hour - n_hours.hours).beginning_of_hour
    hours = prepare_array(start_time, 1.hour)

    # Fetch the relevant data from the database
    bts = BeverageTab.where("created_at >= ? AND created_at <= ?", start_time, DateTime.now)
    bt_data = {}
    bts.each do |bt|
      bt_data[bt.name] ||= {}
      # initialize the hash with 0 values for every hour
      hours.each do |h|
        bt_data[bt.name][h] ||= 0
      end
      # Add the count for each name/timestamp-pair
      bt_data[bt.name][bt.created_at.beginning_of_hour.to_i] += bt.count
    end

    # bring the data in the correct format for rickshaw
    return rickshaw_format(bt_data)
  end

  def self.get_daily_stats(n_days)
    # start_time = (start_time - n_days.days).beginning_of_day
    start_time = (DateTime.now.utc.beginning_of_day - n_days.days).beginning_of_day
    days = prepare_array(start_time, 1.day)

    bts = BeverageTab.where("created_at >= ? AND created_at <= ?", start_time, DateTime.now)
    bt_data = {}
    bts.each do |bt|
      bt_data[bt.name] ||= {}
      # initialize the hash with 0 values for every day
      days.each do |d|
        bt_data[bt.name][d] ||= 0
      end
      # Add the count for each name/timestamp-pair
      bt_data[bt.name][bt.created_at.beginning_of_day.to_i] += bt.count
    end

    # bring the data in the correct format for rickshaw
    return rickshaw_format(bt_data)
  end

  private
  # Prepares an array with every step (1.hour) in the range
  def self.prepare_array(start_time, step)
    ary = []
    ts = start_time
    end_time = DateTime.now
    while ts <= end_time
      ary << ts.to_i
      ts += step
    end
    return ary
  end

  def self.rickshaw_format(bt_data)
    stat_data = []
    bt_data.each do |name,b|
      tmp_hash = {}
      tmp_array = []
      b.each do |k,v|
        tmp_array << {x: k, y: v}
      end
      # Rickshaw wants the data to be sorted by the x-coordinate
      tmp_array.sort_by!{ |k,v| k[:x] } 
      tmp_hash[:data] = tmp_array
      tmp_hash[:name] = name
      stat_data << tmp_hash
    end
    return stat_data
  end
end