json.status 'ok'
json.data(@left_list) do |group|
  json.id group.ID
  json.name group.Name
  json.children(group.second_groups_by(session[:city_id])) do |s_group|
    json.id s_group.ID
    json.name s_group.Name
  end
end
