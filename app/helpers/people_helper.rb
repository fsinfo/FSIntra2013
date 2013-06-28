module PeopleHelper
  def render_tag_list(tags)
    tags.map {|t| link_to t, tag_people_path(t)}.join(', ').html_safe
  end
end
