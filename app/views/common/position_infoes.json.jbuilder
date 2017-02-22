json.status 'ok'
position_infoes = []
counties = current_user.addresses.includes(:county => [:city]).map{|address| address.county}.compact.uniq
counties.each do |county|
  hash = Hash.new()
  hash[:city_id] = county.city.ID
  hash[:company_id] = county.city.CompanyID
  hash[:county_id] = county.ID
  hash[:county_name] = county.CountyName
  position_infoes << hash
end
json.position_infoes position_infoes

