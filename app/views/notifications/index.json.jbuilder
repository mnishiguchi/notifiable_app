# This is a template for JSON but renders an HTML partial and embed it into the json template.
# The HTML partial is pulled from an appropreate directory following the following convention:
#
#   notification/<pluralized model name>/_<notification action name>
#
json.array! @notifications do |notification|
  json.id notification.id
  json.unread !notification.read_at?
  json.template render({
    partial: "notifications/#{notification.notifiable_type.underscore.pluralize}/#{notification.action}",
    locals: { notification: notification },
    formats: [:html]
  })
end
