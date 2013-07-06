module MinutesHelper

  # nicer output
  def motion_result motion
  	str = (motion.approved? ? "Genehmigt: " : "Nicht genehmigt: ") + [motion.pro, motion.con, motion.abs].join(' | ')
  	content_tag :span, str, :title => 'Dafür | Dagegen | Enthaltung'
  end

end
