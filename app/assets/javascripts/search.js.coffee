do ($ = jQuery, scope = window) ->

  unless window.Search
    scope.Search = {}

  scope.Search.instant_search = ->
    $('.search-form .search input').keyup ->
      scope.Search.perform_search()
      return false

    $('.ajax-input input').change ->
      scope.Search.perform_search()

  scope.Search.perform_search = ->
    $.get $('.search-form').attr('action'), $('.search-form').serialize(), null, "script"