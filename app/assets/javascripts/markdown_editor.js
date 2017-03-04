// NOTE: Currently assets pipeline raises an error for ES6 Javascript at compilation.

window.App = window.App || {}
App.markdownEditor = {}

/**
 * Converts all the textareas into a markdown editor.
 */
App.markdownEditor.init = function() {

  // https://sevos.io/2017/02/27/turbolinks-lifecycle-explained.html
  document.addEventListener('DOMContentLoaded', setup())
  document.addEventListener('turbolinks:render', setup())
  document.addEventListener('turbolinks:before-render', teardown())

  function setup() {
    // Ensure that text area exists on the page.
    // https://github.com/NextStepWebs/simplemde-markdown-editor/issues/478
    if (document.querySelector('textarea')) {
      // Store the reference to window.App object.
      App.simplemde = new SimpleMDE()
    }
  }

  function teardown() {
    if (App.simplemde) {
      // https://github.com/NextStepWebs/simplemde-markdown-editor#removing-simplemde-from-textarea
      App.simplemde.toTextArea()
      App.simplemde = null
    }
  }

  return App.simplemde
}

App.markdownEditor.init()
