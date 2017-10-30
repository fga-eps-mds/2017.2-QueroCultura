function poolColors(a) {
    var pool = [];
    for(i=0;i<a;i++){
        pool.push(dynamicColors());
    }
    return pool;
}

function dynamicColors() {
    var r = Math.floor(Math.random() * 255);
    var g = Math.floor(Math.random() * 255);
    var b = Math.floor(Math.random() * 255);
    return "rgb(" + r + "," + g + "," + b + ")";
}

function public_private_chart(amount_public_libraries, amount_private_libraries){
  var ctx = document.getElementById('pie-chart-library').getContext('2d');
  var chart = new Chart(ctx, {
    // The type of chart we want to create
    type: 'pie',

    // The data for our dataset
    data: {
        labels: ["Pública", "Privada"],
        datasets: [{
            label: "Points",
            data: [amount_public_libraries, amount_private_libraries],
            backgroundColor: [
              'rgba(255, 51, 51, 1)',
              'rgba(153, 255, 51, 1)',
            ]
        }]
    },
    // Configuration options go here
    options: {
      cutoutPercentage: 50,
      animation:{
        animateScale: true,
      },
      title: {
        display: true,
        text: 'Porcentagem de bibliotecas públicas e privadas'
      }
    }
  });
}

function bar_chart(indicators, chartId, labelName, description){
    var ctxArea = document.getElementById(chartId);

    var nameArea = [];
    var amountArea = [];
    jQuery.each(indicators, function(key, value){
      nameArea.push(key);
      amountArea.push(value);
    });

    var chart = new Chart(ctxArea, {
                            type: 'bar',
                            data: {
                                labels: nameArea,
                                datasets: [{
                                    label: labelName,
                                    data: amountArea,
                                    backgroundColor: poolColors(amountArea.length)
                                }]
                            },
                            options: {
                                scales: {
                                    yAxes: [{
                                        ticks: {beginAtZero:true}
                                   }]
                               },
                               legend: {display: true},
                               title: {display: true,
                                       text: description
                               }
                            }
                        });

}

function line_chart(indicators, chartId, labelName, description){
        var ctx = document.getElementById(chartId);
        var name_growth = [];
        var temp_growth = [];
        jQuery.each(indicators, function(key, value){
          name_growth.push(key);
          temp_growth.push(value);
        });

        var agentchart = new Chart(ctx, {
                                type: 'line',
                                data: {labels: name_growth,
                                       datasets: [{
                                                    label: labelName,
                                                    data: temp_growth,
                                                    fill: false,
                                                    borderWidth: 2.5,
                                                    borderColor: 'rgba(77,166,253,0.85)',
                                                    backgroundColor: 'transparent',
                            	                    bordeCapStyle: 'butt',
                        	                        borderDash: [],
                                	                borderJoinStyle: 'miter',
                                	                pointBorderColor: "rgba(75,192,192,1",
                                	                pointBackgroundColor: "fff",
                            	                    pointBorderWidth: 3,
                                	                pointHoverRadius: 5,
                            	                    pointHoverBackgroundColor: "rgba(75,192,192,1)",
                                	                pointHoverBorderColor: "rgba(220,220,220,1)",
                                	                pointHoverBorderWidth: 2,
                                	                pointRadius: 1,
                                	                pointHitRadius: 10
                                                }]
                                        },
                                options: {title: {display: true,
                                                  text: description
                                                }
                                        }
                        });
}
