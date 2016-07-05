a = require 'poem'
$ = require 'jquery'
_ = require 'underscore'

$(document).ready ->
  $('#generate').click ->
    li = _(a.RandomizeAll()).map (name) -> "<li>#{name}</li>"
    $('#results').html(li)
    ga 'send', 'event', 'generate', 'click'
