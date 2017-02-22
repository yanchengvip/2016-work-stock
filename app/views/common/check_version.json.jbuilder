if @version
  json.status 'ok'
  json.data do
    json.(@version, :Version, :Content, :Url, :Force, :MinOldVersion)
  end
else
  json.status 'error'
  json.code 'no_version_information'
  json.message '没有找到相应的版本信息'
end
