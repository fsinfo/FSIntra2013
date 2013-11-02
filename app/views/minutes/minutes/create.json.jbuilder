json.minute do
  json.extract! @minutes_minute, :date, :keeper_of_the_minutes_id, :chairperson_id, :released_date, :has_quorum, :errors
end

json.forward_to @forward if @forward