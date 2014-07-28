# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready( ->
  $('#transactions').DataTable
    paging: true

  $.getJSON($('transaction-chart').data('url'), (data) ->
    newData = data
    # Create the chart
    $('#transaction-chart').highcharts('StockChart', {
      rangeSelector :
        selected : 1,
        inputEnabled: $('#container').width() > 480

      title :
        text : 'Umsatzverlauf'

      series : [{
        name : 'AAPL',
        data : newData,
        tooltip: {
          valueDecimals: 2
        }
      }]
    })
  )
)
