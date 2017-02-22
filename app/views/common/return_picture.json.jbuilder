json.status 'ok'
json.data do
  json.open_screens(@open_screens) do |open_screen|
    json.title open_screen.Title
    json.picture open_screen.cover_url
  end
end