# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  md = window.markdownit({
      highlight: (str, lang) -> 
        if lang and hljs.getLanguage(lang)
          try
            """
            <pre class='hljs'><code>
              #{hljs.highlight(lang, str, true).value}
            </code></pre>
            """
          catch __
        else
          "<pre class='hljs'><code>#{md.utils.escapeHtml(str)}</code></pre>"
    })
  $('#preview-tab').click ->
    $('#preview').html md.render($('#article_content').val())