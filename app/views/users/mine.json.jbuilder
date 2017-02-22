json.status 'ok'
json.data do
  json.is_verified current_user.verified_addresses.size > 0
  json.user_level current_user.user_level.try(:UserLevel).to_i
  json.level_name current_user.level_name
  json.phone current_user.Phone
end
