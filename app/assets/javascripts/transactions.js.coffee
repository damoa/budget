# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready( ->
  $('#transactions').DataTable
    paging: true

  $.getJSON($('#transaction-chart').data('url'), (data) ->
    arr = data
    for i in [0..data.length-1]
      data[i][0] = arr[i][0]
      data[i][1] = parseFloat(arr[i][1])
    
    # Create the chart
    $('#transaction-chart').highcharts('StockChart', {
      rangeSelector :
        selected : 1,
        inputEnabled: $('#container').width() > 480

      title :
        text : 'Umsatzverlauf'

      series : [{
        name : 'AAPL',
        data : data,
        tooltip: {
          valueDecimals: 2
        }
      }]
    })
  )
)
