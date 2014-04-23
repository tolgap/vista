# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
do ($ = jQuery, scope = window) ->

  unless window.Server
    scope.Server = {}

  scope.Server.SetMail = ->
    $input = $('.form-server-set-mail #server_has_mail')
    $input.on 'change', ->
      $('.form-server-set-mail').submit();
      if $input.attr('checked')
        $('.message-checked').toggleClass('hidden')
        setTimeout( ->
          $('.message-checked').toggleClass('hidden')
        , 5000)
      else
        $('.message-unchecked').toggleClass('hidden')
        setTimeout( ->
          $('.message-unchecked').toggleClass('hidden')
        , 5000)