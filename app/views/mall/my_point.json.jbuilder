json.status 'ok'
json.data(@point_histories) do |ph|
  json.type ph.type_tos
  json.time ph.CreateTime.strftime("%Y-%m-%d %H:%M")
  json.delta_point ph.DeltaPoint
end
