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

    # bar chart
  $.getJSON $('#container').data('url'), ->
    $('#container').highcharts({
        chart: {
            type: 'bar'
        },
        title: {
            text: 'Eingaben und Ausgaben nach Art'
        },
        # subtitle: {
        #     text: 'Source: Wikipedia.org'
        # },
        xAxis: {
            categories: ['Africa', 'America', 'Asia', 'Europe', 'Oceania'], # need months
            title: {
                text: null
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Population (millions)', # need amount
                align: 'high'
            },
            labels: {
                overflow: 'justify'
            }
        },
        tooltip: {
            valueSuffix: ' €'
        },
        plotOptions: {
            bar: {
                dataLabels: {
                    enabled: true
                }
            }
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'top',
            x: -40,
            y: 100,
            floating: true,
            borderWidth: 1,
            backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
            shadow: true
        },
        credits: {
            enabled: false
        },
        series: [{
            name: 'Year 1800', # automatic_bill_payment, charge, credit_entry, deposit, interest, money_transfer, payout, reversal, salary, withdrawal
            data: [107, 31, 635, 203, 2]
        }, {
            name: 'Year 1900',
            data: [133, 156, 947, 408, 6]
        }, {
            name: 'Year 2008',
            data: [973, 914, 4054, 732, 34]
        }]
    });
