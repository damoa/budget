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
      payments[i] = []
      payments[i].push(parseInt(arr[i][0]))
      payments[i].push(parseFloat(arr[i][1]))
      balances[i] = []
      balances[i].push(parseInt(arr[i][0]))
      balances[i].push(parseFloat(arr[i][2]))
    
    $('#transaction-chart').highcharts('StockChart',{
      title:
        text: 'Haushalt'
        x: -20 #center
      subtitle:
        text: 'Täglicher KontoStand'
        x: -20
      rangeSelector :
        selected : 1
        inputEnabled: $('#transaction-chart').width() > 480
      xAxis:
        type: 'datetime'
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
    })

jQuery ->
  $.getJSON $('#canvas').data('url'), (data) ->
    arr = data
    dates = []
    payments = []
    balances = []
    for i in [0..data.length-1]
      dates.push(arr[i][0])
      balances[i] = []
      balances[i].push(Math.round(arr[i][1]*100)/100)
    maxPayment = Math.max(balances)

    data = {
      labels : dates
      datasets : [
        {
          fillColor : "rgba(220,220,220,0.5)",
          strokeColor : "rgba(220,220,220,1)",
          pointColor : "rgba(220,220,220,1)",
          pointStrokeColor : "#fff",
          data : [1]
        },
        {
          fillColor : "rgba(220,220,220,0.5)",
          strokeColor : "rgba(151,187,205,1)",
          pointColor : "rgba(151,187,205,1)",
          pointStrokeColor : "#fff",
          data : balances
        }
      ]
    }

    myNewChart = new Chart($("#canvas").get(0).getContext("2d")).Line(data)

  $.getJSON $('#canvas2').data('url'), (data) ->
    arr = data
    dates = []
    payments = []
    balances = []
    for i in [0..data.length-1]
      dates.push(arr[i][0])
      balances[i] = []
      balances[i].push(-Math.round(arr[i][1]*100)/100)
    maxPayment = Math.max(balances)

    data = {
      labels : dates
      datasets : [
        {
          fillColor : "rgba(220,220,220,0.5)",
          strokeColor : "rgba(220,220,220,1)",
          pointColor : "rgba(220,220,220,1)",
          pointStrokeColor : "#fff",
          data : [1]
        },
        {
          fillColor : "rgba(220,220,220,0.5)",
          strokeColor : "rgba(151,187,205,1)",
          pointColor : "rgba(151,187,205,1)",
          pointStrokeColor : "#fff",
          data : balances
        }
      ]
    }

    myNewChart = new Chart($("#canvas2").get(0).getContext("2d")).Bar(data)

  $.getJSON $('#canvas3').data('url'), (data) ->
    arr = data
    dates = []
    payments = []
    balances = []
    for i in [0..data.length-1]
      dates.push(arr[i][0])
      balances[i] = []
      balances[i].push(Math.abs(arr[i][1]))
    maxPayment = Math.max(balances)

    data = {
      labels : dates
      datasets : [
        {
          fillColor : "rgba(220,220,220,0.5)",
          strokeColor : "rgba(151,187,205,1)",
          pointColor : "rgba(151,187,205,1)",
          pointStrokeColor : "#fff",
          data : balances
        }
      ]
    }

    myNewChart = new Chart($("#canvas3").get(0).getContext("2d")).Radar(data)
