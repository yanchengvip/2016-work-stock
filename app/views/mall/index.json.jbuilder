json.status 'ok'
json.data do
  json.integral current_user.Integral.to_i
  json.cash_voulme current_user.CashVolume.to_f
  json.point_products(@point_products) do |pp|
    json.id pp.ID
    json.name pp.Name
    json.cover pp.cover_url
    json.original_price pp.OriginalPrice
    json.point pp.Point
  end
end
