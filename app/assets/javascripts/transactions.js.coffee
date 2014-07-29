# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $('#transactions').DataTable
    paging: true
  
  $.getJSON $('#transaction-chart').data('url'), (data) ->
    arr = data
    dates = []
    payments = []
    balances = []
    for i in [0..data.length-1]
      dates.push(arr[i][0])
      payments.push(parseFloat(arr[i][1]))
      balances.push(parseFloat(arr[i][2]))
    
    $('#transaction-chart').highcharts
      title:
        text: 'Haushalt'
        x: -20 #center
      subtitle:
        text: 'Täglicher KontoStand'
        x: -20
      xAxis:
        categories: dates
      yAxis:
        title:
          text: 'EUR'
      plotLines:
        value: 0
        width: 1
        color: '#808080'
      tooltip:
        valueSuffix: ' €'
      legend:
        layout: 'vertical'
        align: 'right'
        verticalAlign: 'middle'
        borderWidth: 0
      series: [
        { name: 'Kontostand', data: balances }
        { name: 'Zahlungseingang', data: payments }
      ]
