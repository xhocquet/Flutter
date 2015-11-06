$(function () { 

  var hideCrapOptions = {
    credits: {enabled: false},
    exporting: {enabled: false},
    tooltip: {enabled: false},
    legend: {enabled: false},
    chart: {
      backgroundColor: null
    }
  };

  $('#count_to_date_heatmap').highcharts(Highcharts.merge(hideCrapOptions, {
      chart: {
          type: 'heatmap'
      },
      title: {
        text: ''
      },
      xAxis: {
          categories: ['','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
          title: 'Month'
      },
      yAxis: {
        title: 'Year',
      },
      colorAxis: {
        min: 0,
        max: 40,
        minColor: '#FFE0B3',
        maxColor: '#F57C00'
      },        
      series: [{
        type: 'heatmap',
          data: month_count_array,
          dataLabels: {
              enabled: true,
              color: '#000000'
          }
      }]
  }));
});
