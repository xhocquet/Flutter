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

  $('#rating_distribution_line').highcharts(Highcharts.merge(hideCrapOptions, {
      xAxis: {
          title: 'Score',
          min: 1
      },
      yAxis: {
        title: 'Num Shows',
        min: 0
      },
      title: {
        text: ''
      },
      series: [{
          data: rating_count_array,
          color: '#FF9800',
          dataLabels: {
              enabled: true,
              color: '#000000'
          }
      }]
  }));

  $('#year_rating_line').highcharts(Highcharts.merge(hideCrapOptions, {
      xAxis: {
          title: 'Year'
      },
      yAxis: {
        title: 'Mean Rating',
        min: 0,
        max: 5
      },
      title: {
        text: ''
      },
      series: [{
          data: score_year_array,
          color: '#FF9800',
          dataLabels: {
              enabled: true,
              color: '#000000'
          }
      }]
  }));

  $('#genre_rating_barchart').highcharts(Highcharts.merge(hideCrapOptions, {
      xAxis: {
          title: 'Genre',
          categories: score_genre_label_array
      },
      yAxis: {
        title: 'Mean Rating',
        min: 0,
        max: 5
      },
      title: {
        text: ''
      },
      series: [{
          data: score_genre_array,
          color: '#FF9800',
          dataLabels: {
              enabled: true,
              color: '#000000'
          }
      }],
      tooltip: {
        enabled: true,
        formatter: function() {
          return this.x + ': ' + this.y;
        }
      }
  }));
});
