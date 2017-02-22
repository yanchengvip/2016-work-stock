json.status 'ok'
json.data do
  notifications = current_user.notifications
  json.notifications(notifications) do |notification|
    json.link notification.link
    json.create_time notification.CreateTime.strftime("%m-%d　%H:%M")
    json.type notification.Type
    json.content notification.Content
  end
  notifications.update_all(IsRead: true)
end