  //GRAPHS
  $(function () { 

    // Make monochrome colors and set them as default for all pies
    Highcharts.getOptions().plotOptions.pie.colors = (function () {
        var colors = [],
            base = '#FF9800',
            i;

        for (i = 0; i < 10; i += 1) {
            // Start out with a darkened base color (negative brighten), and end
            // up with a much brighter color
            colors.push(Highcharts.Color(base).brighten((i - 3) / 7).get());
        }
        return colors;
    }());

    $('#show_status_barchart').highcharts({
        chart: {
            type: 'column'
        },
        title: {
        	text: ''
        },
        xAxis: {
            categories: ['Current', 'Plan to Watch', 'Finished', 'On Hold', 'Dropped']
        },
        legend: {
        	enabled: false
        },
        tooltip: {
        	enabled: false
        },
        exporting: {
        	enabled: false
        },
        yAxis: {
            title: 'Num Shows'
        },
        series: [{
            data: show_status_array,
            pointWidth: 40,
            color: '#FF9800',
            dataLabels: {
                enabled: true,
                color: '#000000'
            }
        }]
    });

    $('#rating_distribution_line').highcharts({
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
        legend: {
        	enabled: false
        },
        tooltip: {
        	enabled: false
        },
        exporting: {
        	enabled: false
        },
        series: [{
            data: rating_count_array,
            color: '#FF9800',
            dataLabels: {
                enabled: true,
                color: '#000000'
            }
        }]
    });

    $('#count_to_date_heatmap').highcharts({
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
        legend: {
          enabled: false
        },
        tooltip: {
          enabled: false
        },
        exporting: {
          enabled: false
        },
        colorAxis: {
          min: 0,
          max: 100,
          minColor: '#FFECB3',
          maxColor: '#FF9800'
        },        
        series: [{
          type: 'heatmap',
            data: month_count_array,
            dataLabels: {
                enabled: true,
                color: '#000000'
            }
        }]
    });

    $('#year_aired_line').highcharts({
    	chart: {
        type: 'column'
    	},
      xAxis: {
        title: 'Year Aired',
      },
      yAxis: {
        title: 'Num Shows',
        min: 0
      },
      title: {
      	text: ''
      },
      legend: {
        enabled: false
      },
      tooltip: {
        enabled: false
      },
      exporting: {
        enabled: false
      },
      series: [{
        data: year_count_array,
        color: '#FF9800',
        dataLabels: {
          enabled: true,
          color: '#000000'
        }
      }]
    });

    $('#show_type_pie').highcharts({
      chart: {
        plotBackgroundColor: null,
        plotBorderWidth: null,
        plotShadow: false,
        type: 'pie'
      },
      title: {
        text: ''
      },
      yAxis: {
          categories: ['Music','Movie','ONA','TV','Special','OVA']
      },
      legend: {
        enabled: false
      },
      tooltip: {
        enabled: false
      },
      exporting: {
        enabled: false
      },
      plotOptions: {
          pie: {
              allowPointSelect: true,
              cursor: 'pointer',
              dataLabels: {
                  enabled: true
              }
          }
      },
      series: [{
          name: "Show Types",
          data: anime_type_array
      }]
    });


  });