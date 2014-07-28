do ($ = jQuery, scope = window) ->
  $.extend true, $.fn.dataTable.defaults,
    # bStateSave: true
    iDisplayLength: 25,
    sDom: '<"clear">lfrtipT'
    # fnStateSave: (oSettings, oData) ->
    #   localStorage.setItem "dt-" + window.location.pathname, JSON.stringify(oData)
    # fnStateLoad: (oSettings) ->
    #   JSON.parse localStorage.getItem("dt-" + window.location.pathname)

  $.fn.dataTable.defaults.aLengthMenu = [
    [25, 50, 75, 100],
    [25, 50, 75, 100]
  ]

  unless window.DataTable
    scope.DataTable = {}
    listen_for_deletes

  scope.DataTable.Website = ->
    $('.websites.datatable').dataTable(
      aoColumns: [{ "bSortable": true},
        { "bSortable": false},
        { "bSortable": true},
        { "bSortable": true},
        { "bSortable": true},
        { "bSortable": true},
        { "bSortable": false}
        { "bSortable": false}]
    ).columnFilter(
      aoColumns: [null,
        { "type": "select"},
        { "type": "select"},
        null,
        null,
        null,
        null,
        null,]
    )

  scope.DataTable.Plugin = ->
    $('.plugins.datatable').dataTable(
      aoColumns: [{ "bSortable": true},
        { "bSortable": true},
        { "bSortable": true},
        { "bSortable": true},
        { "bSortable": false}]
    ).columnFilter(
      aoColumns: [null,
        null,
        { "type": "select"},
        { "type": "select"},
        null,]
    )

  listen_for_deletes = ->
    table = $('.datatable').DataTable()

    $('.datatable tbody tr').on 'click', 'a.delete', ->
      table
        .row($(this).parents('tr'))
        .remove
        .draw
