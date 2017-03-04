function setTimezoneCookie() {

  setCookie('tz', getTimezoneName())

  function getTimezoneName() {
    // https://medium.com/@jonathanabrams/be-aware-of-browsers-internationalization-api-db94bb32f9a8#.hjgg1453j

    // Temporarily remove Intl object before calling jstz in order to ensure that jstz uses older timezone format.
    // If the Intl object exists, jstz will detect a newer timezone format.
    // We want to use older timezone format so that Rails can understand.
    var oldIntl = window.Intl
    window.Intl = undefined

    // Get the usee's timezone name.
    var tzName  = jstz.determine().name()

    // Restore the Intl object.
    window.Intl = oldIntl

    return tzName
  }

  function setCookie(key, value) {
    // http://nithinbekal.com/posts/rails-user-timezones
    var expires     = new Date()
    var currentTime = expires.getTime()
    var duration    = 24 * 60 * 60 * 1000
    expires.setTime(currentTime + duration)

    document.cookie = key + '=' + value + ';expires=' + expires.toUTCString()
  }
}
