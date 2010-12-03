var chart;

$(document).ready(function(){
		// define the options
		var options = {
	
			chart: {
				renderTo: 'container',
        events: {
          load: function() {
            var series = this.series[0];
            setInterval(function() {
              $.getJSON('active_clients', null, function(data) {
                  var y = data;
                  var x = (new Date()).getTime() // current time
                  series.addPoint([x, y], true, true);
              });
            }, 1000);
          }
        }
			},
			
			title: {
				text: 'Liczba aktywnych klientów'
			},
			
			subtitle: {
				text: 'TopServer'
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
			
			legend: {
				align: 'left',
				verticalAlign: 'top',
				y: 20,
				floating: true,
				borderWidth: 0
			},
			
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
				name: 'Aktywni klienci',
				lineWidth: 4,
        pointInterval : 10,
				marker: {
					radius: 4
				}
			}]
		}
		$.getJSON('clients_history', null, function(data) {
      clients = [];
      $.each(data, function(i,e){
			// split the data return into lines and parse them
					clients.push([
            e[0]*1000,
            e[1]
					]);
      });
      console.log("----");
			options.series[0].data = clients;
			
			chart = new Highcharts.Chart(options);
		});
});
