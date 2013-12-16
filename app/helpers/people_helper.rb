module PeopleHelper
  def render_tag_list(tags)
    tags.split(',').map {|t| link_to t, tag_people_path(t)}.join(', ').html_safe unless tags.nil?
  end

  def cache_key_for_people
      count          = Person.count
      max_updated_at = Person.maximum(:updated_at).try(:utc).try(:to_s, :number)
      "people/all-#{count}-#{max_updated_at}"
    end
end
