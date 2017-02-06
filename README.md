# Notifiable app

In this app, I will learn how to build notification functionality through analyzing the
[gorails-screencasts/gorails-episode-124-notifications](https://github.com/gorails-screencasts/gorails-episode-124-notifications) example app.

## Dependencies
- Ruby 2.3.1
- Rails 5.0.1
- Devise
- [Bootstrap 4](https://v4-alpha.getbootstrap.com/getting-started/introduction/)
- and much more

---

## Model

![](erd/erd.jpg)

## Notification system

#### Model
- polymorphic `Notification` model

#### View
- Renders JSON with an HTML template embedded within.
- By convention, an apropriate HTML partial is rendered from: `app/views/notifications/<plural model name>/_<notification action name>`

```js
[
  {
    id: 46,
    unread: true,
    template: "<a class="dropdown-item unread" href="/forum_threads/25#forum_post_101">user3@example.com posted forum post</a>"
  },
  //...
]
```

#### Javascript
- `app/assets/javascripts/notifications.js`
- DOM manipulation
- Fetch notification data every 5 seconds

---

## Some techniques

#### Generate DOM id string
- [rails/ActionView/RecordIdentifier/dom_id](http://apidock.com/rails/ActionView/RecordIdentifier/dom_id)
