do ($ = jQuery, scope = window) ->
  $.extend true, $.fn.dataTable.defaults,
    bStateSave: true
    sDom: '<"clear">lfrtipT'
    fnStateSave: (oSettings, oData) ->
      localStorage.setItem "dt-" + window.location.pathname, JSON.stringify(oData)
    fnStateLoad: (oSettings) ->
      JSON.parse localStorage.getItem("dt-" + window.location.pathname)

  unless window.DataTable
    scope.DataTable = {}

  scope.DataTable.Website = ->
    $('.websites.datatable').dataTable
      aoColumns: [{ "bSortable": true},
        { "bSortable": true},
        { "bSortable": true},
        { "bSortable": true},
        { "bSortable": false}]

  scope.DataTable.Plugin = ->
    $('.plugins.datatable').dataTable
      aoColumns: [{ "bSortable": true},
        { "bSortable": true},
        { "bSortable": true},
        { "bSortable": true},
        { "bSortable": false}]