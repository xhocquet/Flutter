  //GRAPHS
  $(function () { 

    // Global Chart Options

    var hideCrapOptions = {
      credits: {enabled: false},
      exporting: {enabled: false},
      tooltip: {enabled: false},
      legend: {enabled: false}
    };

    // Orange color set for pie charts
    Highcharts.getOptions().plotOptions.pie.colors = (function () {
        var colors = [], base = '#F57C00';
        for (var i = 0; i < 10; i += 1) {
            colors.push(Highcharts.Color(base).brighten((i - 3) / 7).get());
        }
        return colors;
    }());

    // GENERAL

    var gaugeOptions = {
        chart: {
            type: 'solidgauge'
        },
        title: null,
        pane: {
          center: ["50%","0"],
            startAngle: 90,
            endAngle: 270,
            background: {
                backgroundColor: '#eee',
                innerRadius: '60%',
                outerRadius: '100%',
                shape: 'arc'
            }
        },
        tooltip: {
            enabled: false
        },
        exporting: {
          enabled: false
        },
        yAxis: {
            minorTickInterval: null,
            tickWidth: 0,
            labels: {
                y: 16
            },
            stops: [
              [0.1, '#FFE0B2',],
              [0.4, '#FF9800',],
              [0.8, '#F57C00']
            ]
        },
        plotOptions: {
          solidgauge: {
            dataLabels: {
              y: 5,
              borderWidth: 0
            }
          }
        }
    };

    $('#total-titles-gauge').highcharts(Highcharts.merge(hideCrapOptions, Highcharts.merge(gaugeOptions, {
        yAxis: {
            min: 0,
            max: db_show_count,
            title: {
                text: ''
            }
        },
        series: [{
            name: 'Shows Watched',
            data: [user_show_count],
            dataLabels: {
                format: '<div style="text-align:center"><span style="font-size:25px;color:' +
                    ((Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black') + '">{y}</span></div>'
            }
        }]
    })));

    $('#total-episodes-gauge').highcharts(Highcharts.merge(hideCrapOptions, Highcharts.merge(gaugeOptions, {
        yAxis: {
            min: 0,
            max: db_episode_count,
            title: {
                text: ''
            }
        },
        series: [{
            name: 'Episodes Watched',
            data: [user_episode_count],
            dataLabels: {
                format: '<div style="text-align:center"><span style="font-size:25px;color:' +
                    ((Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black') + '">{y}</span></div>'
            }
        }]
    })));

    // TRENDS

    $('#show_status_barchart').highcharts(Highcharts.merge(hideCrapOptions, {
        chart: {
            type: 'column'
        },
        title: {
        	text: ''
        },
        xAxis: {
            categories: ['Current', 'Plan to Watch', 'Finished', 'On Hold', 'Dropped']
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
    }));

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
    }));

    $('#year_aired_line').highcharts(Highcharts.merge(hideCrapOptions, { 
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
      series: [{
        data: year_count_array,
        color: '#FF9800',
        dataLabels: {
          enabled: true,
          color: '#000000'
        }
      }]
    }));

    $('#show_type_pie').highcharts(Highcharts.merge(hideCrapOptions, {
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
      plotOptions: {
          pie: {
              dataLabels: {
                  enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                    style: {
                      color: '#000000'
                    },
                    connectorColor: 'black'
              }
          }
      },
      series: [{
          name: "Show Types",
          data: anime_type_array
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


  });