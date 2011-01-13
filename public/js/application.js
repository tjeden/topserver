var chart;

$(document).ready(function(){
		// define the options
		var options = {
	
			chart: {
				renderTo: 'container',
        events: {
          load: function() {
            var series = this.series;
            setInterval(function() {
              $.getJSON('current_clients', null, function(data) {
                  var x = (new Date()).getTime() // current time
                  for (i = 0; 0 < 4; i = i + 1){
                    series[i].addPoint([x, data[i]], true, true);
                  }
              });
            }, 2000);
          }
        }
			},
			
			title: {
				text: 'Liczba klientów'
			},
			
			
			xAxis: {
				type: 'datetime',
				labels: {
					align: 'left',
					x: 3,
					y: -3 
				}
			},
			
			yAxis: [{ // left y axis
				title: {
					text: null
				},
				labels: {
					align: 'left',
					x: 2,
					y: 16,
					formatter: function() {
						return Highcharts.numberFormat(this.value, 0);
					}
				},
				showFirstLabel: false
			}],
			
			tooltip: {
				shared: true,
				crosshairs: true
			},
			
			plotOptions: {
				series: {
					cursor: 'pointer',
					point: {
						events: {
							click: function() {
								hs.htmlExpand(null, {
									pageOrigin: {
										x: this.pageX, 
										y: this.pageY
									},
									headingText: this.series.name,
									maincontentText: Highcharts.dateFormat('%A, %b %e, %Y', this.x) +':<br/> '+ 
										this.y +' visits',
									width: 200
								});
							}
						}
					},
					marker: {
						lineWidth: 1
					}
				}
			},
			
			series: [{
				name: 'Wszyscy klienci',
				lineWidth: 4,
        pointInterval : 10,
				marker: {
					radius: 4
				}
      },{
				name: 'Dostępni klienci',
				lineWidth: 4,
        pointInterval : 10,
				marker: {
					radius: 4
				}
      },{
				name: 'Nieaktywni klienci',
				lineWidth: 4,
        pointInterval : 10,
				marker: {
					radius: 4
				}
      },{
				name: 'Aktywni klienci',
				lineWidth: 4,
        pointInterval : 10,
				marker: {
					radius: 4
				}
			}]
		}
    if ($('#container').length) {
      $.getJSON('clients_history', null, function(data) {
        total = [];
        available = [];
        inactive = [];
        active = [];
        $.each(data, function(i,e){
            total.push([
              e[0]*1000,
              e[1]
            ]);
            available.push([
              e[0]*1000,
              e[2]
            ]);
            inactive.push([
              e[0]*1000,
              e[3]
            ]);
            active.push([
              e[0]*1000,
              e[1]
            ]);
        });
        options.series[0].data = total;
        options.series[1].data = available;
        options.series[2].data = inactive;
        options.series[3].data = active;
        
        chart = new Highcharts.Chart(options);
      });
    }
});
