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

    $('#total_titles_gauge').highcharts(Highcharts.merge(hideCrapOptions, Highcharts.merge(gaugeOptions, {
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

    $('#total_episodes_gauge').highcharts(Highcharts.merge(hideCrapOptions, Highcharts.merge(gaugeOptions, {
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
  });
