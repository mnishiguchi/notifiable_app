// NOTE: Currently assets pipeline raises an error for ES6 Javascript at compilation.

window.App = window.App || {}
App.markdownEditor = {}

/**
 * Converts all the textareas into a markdown editor.
 */
App.markdownEditor.init = function() {
  // turbolinks:before-cache fires before Turbolinks saves the current page to cache.
  // https://github.com/turbolinks/turbolinks#full-list-of-events
  document.addEventListener('turbolinks:before-cache', function() {
    if (App.simplemde) { teardown() }
  })

  document.addEventListener('turbolinks:load', function() {
    setup()
  })

  function setup() {
    // Ensure that text area exists on the page.
    // https://github.com/NextStepWebs/simplemde-markdown-editor/issues/478
    if (document.querySelector('textarea')) {
      // Store the reference to window.App object.
      App.simplemde = new SimpleMDE()
    }
  }

  function teardown() {
    // https://github.com/NextStepWebs/simplemde-markdown-editor#removing-simplemde-from-textarea
    App.simplemde.toTextArea()
    App.simplemde = null
  }

  return App.simplemde
}

App.markdownEditor.init()
