  //GRAPHS
  $(function () { 
    $('#show_status_barchart').highcharts({
        chart: {
            type: 'column'
        },
        title: {
        	text: ''
        },
        xAxis: {
            categories: ['Current', 'Finished', 'Plan to Watch']
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
        	opposite: true
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

    $('#rating_distribution_line').highcharts({
        xAxis: {
            title: 'Score',
            min: 0
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
  });