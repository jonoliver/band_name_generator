a = require 'app'
$ = require 'jquery'
_ = require 'underscore'
# console.log a.RandomizeAll().join('\n')

$(document).ready ->
  $('#generate').click ->
    li = _(a.RandomizeAll()).map (name) -> "<li>#{name}</li>"
    $('#results').html(li)
    ga 'send', 'event', 'generate', 'click'
